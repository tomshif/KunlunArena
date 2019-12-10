//
//  EntityClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class EntityClass
{
    var scene:SKScene?
    var game:GameClass?
    
    var name:String
    var headNum:Int
    var bodyNum:Int
    var legsNum:Int
    
    var isTurning:Bool=false
    
    
    var headSprite=SKSpriteNode()
    var bodySprite=SKSpriteNode()
    
    var moveSpeed:CGFloat=5.0
    var turnToAngle:CGFloat=0
    
    let UPDATECYCLE:Int=0
    var TURNRATE:CGFloat=0.1
    
    
    init()
    {
        name="Test"
        headNum=0
        bodyNum=0
        legsNum=0
        headSprite=SKSpriteNode(imageNamed: "head")
        bodySprite=SKSpriteNode(imageNamed: "body")
        
    } // init() - default
    
    init(theScene: SKScene)
    {
        scene=theScene
        name="Test"
        headNum=0
        bodyNum=0
        legsNum=0
        headSprite=SKSpriteNode(imageNamed: "head")
        bodySprite=SKSpriteNode(imageNamed: "body")
        bodySprite.colorBlendFactor=1.0
        bodySprite.color=NSColor.red
        bodySprite.position.x=scene!.size.height/2
        bodySprite.position.y=scene!.size.width/2
        scene!.addChild(bodySprite)
        bodySprite.addChild(headSprite)
        bodySprite.name="entBody"
        headSprite.name="entHead"
        bodySprite.zPosition=10
        headSprite.zPosition=11
        moveSpeed=random(min: 1.5, max: 8.5)
        TURNRATE=random(min: 0.2, max: 0.45)
    } // init(scene)
    
    func getAngleToPlayer() -> CGFloat
    {
                
        let dx=game!.player!.playerSprite!.position.x - bodySprite.position.x
        let dy=game!.player!.playerSprite!.position.y - bodySprite.position.y
        var angle=atan2(dy,dx)
        if angle < 0
        {
            angle += CGFloat.pi*2
        }
        
        return angle
    } // getAngleToPlayer()
    
    func turnTo(pAngle: CGFloat)
    {
        
        var da=pAngle-bodySprite.zRotation // delta angle
        if da > CGFloat.pi
        {
            da -= CGFloat.pi*2
        }
        if da < -CGFloat.pi
        {
            da += CGFloat.pi*2
        }
        print("pAngle: \(pAngle)")
        print("da: \(da)")
        if abs(da) < TURNRATE
        {
            isTurning=false
            bodySprite.zRotation=pAngle
        }
        else
        {
            if da > 0
            {
                bodySprite.zRotation += TURNRATE
            }
            else if da < 0
            {
                bodySprite.zRotation -= TURNRATE
            }
            isTurning=true
        } // else
    } // turnTo()
    
    public func update(cycle: Int)
    {
        if UPDATECYCLE==cycle
        {
            // Simple Follow logic - target player
 
            // get direction to player
            let dx=game!.player!.playerSprite!.position.x - bodySprite.position.x
            let dy=game!.player!.playerSprite!.position.y - bodySprite.position.y
            let angle=atan2(dy,dx)
            
            // Turn towards player
            turnToAngle=angle
            turnTo(pAngle: angle)
            
            // Compute distance to player
            let dist=hypot(dy, dx)
            
        } // if it's our time to update
            
        // move towards player

        let moveDX=cos(bodySprite.zRotation)*moveSpeed
        let moveDY=sin(bodySprite.zRotation)*moveSpeed
        bodySprite.position.x += moveDX
        bodySprite.position.y += moveDY
        
    } // update()
    
} // class EntityClass


