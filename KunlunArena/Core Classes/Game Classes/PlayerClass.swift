//
//  PlayerClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This class holds key player information and is mostly exposed directly to the main (GameScene) code and to other class through the GameClass
//
// This class should not be subclassed at all.
//
// Later in development, we will create a function that copies all key pieces of information that need to be saved into separate class for saving, so that we do not have to make this class compliant with Swift's Codable protocol.


import Foundation
import SpriteKit



class PlayerClass
{
    var game:GameClass?
    var playerSprite:SKSpriteNode?
    var moveToPoint:CGPoint?
    var isMovingToPoint:Bool=false
    var playerName:String?
    var isPlayAction:Bool=false
    
    
    var playerTalents=[PlayerTalentClass]()
    
    var activeTalents=[PlayerTalentClass]()
    
    
    var health:Int=100
    var moveSpeed:CGFloat=10
    
    init()
    {
        
    } // init (default)
    
    
    
    
    init(theGame:GameClass)
    {
        game=theGame
        
        // initialize talents
        
        let tempDash=DashTalentClass(theGame: game!)
        playerTalents.append(tempDash)
        
        
    } // init - game
    
    public func moveTo()
    {
        if isMovingToPoint
        {
            // update movement toward point
            if moveToPoint != nil
            {
            
                let dx=moveToPoint!.x-playerSprite!.position.x
                let dy=moveToPoint!.y-playerSprite!.position.y
                let angle=atan2(dy,dx)
                playerSprite!.zRotation=angle
                playerSprite!.position.x += cos(angle)*moveSpeed
                playerSprite!.position.y += sin(angle)*moveSpeed
                
                // Get distance to point
                let dist = hypot(dy,dx)
                if dist < moveSpeed
                {
                    isMovingToPoint=false
                    
                }
            } // if moveToPoint is not nil
        } // if moving to point
    } // moveTo()
    
    private func checkActions()
    {
        isPlayAction=playerSprite!.hasActions()
    } // checkActions
    
    private func updateTalents()
    {
        if activeTalents.count > 0
        {
            for i in 0..<activeTalents.count
            {
                activeTalents[i].updateTalent()
                if activeTalents[i].activeLengthLeft() < 0 && activeTalents[i].isActive
                {
                    activeTalents[i].removeTalent()
                    activeTalents.remove(at: i)
                    
                    break
                } // if it's time to remove the talent
                
                
            } // for each active talent
        } // if there are active talents
    } // updateTalents()
    
    public func update()
    {
        updateTalents()
        checkActions()
        moveTo()
        
    } // update()
    
    
} // PlayerClass
