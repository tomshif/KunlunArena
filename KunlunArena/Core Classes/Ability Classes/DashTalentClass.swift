//
//  DashTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/24/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This is an example talent that bosts the player's speed by 50% for 2 seconds with a 5 second cooldown.
//

import Foundation
import SpriteKit

class DashTalentClass:PlayerTalentClass
{
    var dashDistance:CGFloat=400
    var dashSpeed:CGFloat=1.5
    var lastStreak=NSDate()
    var streak=SKSpriteNode(imageNamed: "dashStreak")
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="Dash"
        description="Boosts player movement speed by 50% for 5 seconds. 10 second cooldown."
        isAction=false
        game=theGame
        COOLDOWN=10
        lengthActive=5
    } // init game
    
    
    override func removeTalent()
    {
        // This talent will be called when the talent expires.
        // Note that this will always be called from the GameScene and should not be called internally.

        
        game!.player!.moveSpeed /= dashSpeed
        isActive=false
    } // removeTalent()
    
    
    override func updateTalent()
    {
        // This method is called each frame while the method is active
        // If the talent is a one shot thing, this method won't need to do anything.
        // Note that this will always be called from the GameScene and should not be called internally.
        
        if -lastStreak.timeIntervalSinceNow > 0.01
        {
            let tempStreak=streak.copy() as! SKSpriteNode
            tempStreak.position=game!.player!.playerSprite!.position
            tempStreak.run(SKAction.move(by: CGVector(dx: random(min: -100, max: 100), dy: random(min: -100, max: 100)), duration: 0.5))
            tempStreak.run(SKAction.sequence([SKAction.rotate(byAngle: 6, duration: 0.5),SKAction.removeFromParent()]))
            tempStreak.setScale(random(min: 0.25, max: 1.0))
            tempStreak.colorBlendFactor=1.0
            tempStreak.color=NSColor(calibratedRed: random(min: 0.5, max: 1.0), green: random(min: 0.5, max: 1.0), blue: random(min: 0.5, max: 1.0), alpha: 1.0)
            tempStreak.alpha=random(min: 0.7, max: 0.7)
            tempStreak.zPosition=8
            game!.scene!.addChild(tempStreak)
            lastStreak=NSDate()
        } // if time to leave another streaky-star
        
    } // updateTalent()
    
    override func doTalent()
    {
        // This method will be called when the talent is first begun.
        // Note that this will always be called from the GameScene and should not be called internally.
        
        game!.player!.moveSpeed*=dashSpeed
        lastUse=NSDate()
        isActive=true
            

    } // doTalent()
    
} // class DashTalentClass
