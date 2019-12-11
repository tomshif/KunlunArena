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
    var entID:Int=0
    var headNum:Int
    var bodyNum:Int
    var legsNum:Int
    
    var isTurning:Bool=false
    var isPursuing:Bool=false
    
    
    var headSprite=SKSpriteNode()
    var bodySprite=SKSpriteNode()
    
    var moveSpeed:CGFloat=5.0
    var turnToAngle:CGFloat=0
    var attackRange:CGFloat=15
    var pursueRange:CGFloat=15

    var playerDist:CGFloat=0
    
    
    var VISIONDIST:CGFloat=500
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
    
    init(theScene: SKScene, id: Int)
    {
        scene=theScene
        name=String(format:"Ent%5d",id)
        entID=id
        
        headNum=0
        bodyNum=0
        legsNum=0
        headSprite=SKSpriteNode(imageNamed: "head")
        bodySprite=SKSpriteNode(imageNamed: "body")
        bodySprite.colorBlendFactor=1.0
        bodySprite.color=NSColor(calibratedRed: random(min: 0, max: 1.0), green: random(min: 0, max: 1), blue: random(min: 0, max: 1), alpha: 1.0)
        bodySprite.position.x=scene!.size.height/2
        bodySprite.position.y=scene!.size.width/2
        scene!.addChild(bodySprite)
        bodySprite.addChild(headSprite)
        bodySprite.name=String(format:"entBody%5d",id)
        headSprite.name=String(format:"entHead%5d",id)
        bodySprite.zPosition=10
        headSprite.zPosition=11
        moveSpeed=random(min: 1.5, max: 8.5)
        TURNRATE=random(min: 0.25, max: 0.45)
        attackRange=random(min: 25, max: 200)
        VISIONDIST=random(min: 500, max: 1000)
        if attackRange > 45
        {
            pursueRange=attackRange*2
        }
        else
        {
            pursueRange=attackRange
        }
    } // init(scene)
    
    internal func getAngleToPlayer() -> CGFloat
    {
                
        let dx=game!.player!.playerSprite!.position.x - bodySprite.position.x
        let dy=game!.player!.playerSprite!.position.y - bodySprite.position.y
        var angle=atan2(dy,dx)
        
        // normalize angle
        if angle < 0
        {
            angle += CGFloat.pi*2
        }
        
        return angle
    } // getAngleToPlayer()
    
    internal func turnTo(pAngle: CGFloat)
    {
        
        var da=pAngle-bodySprite.zRotation // delta angle
        
        // normalize delta angle
        if da > CGFloat.pi
        {
            da -= CGFloat.pi*2
        }
        if da < -CGFloat.pi
        {
            da += CGFloat.pi*2
        }

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
    
    public func die()
    {
        bodySprite.removeAllChildren()
        bodySprite.removeAllActions()
        bodySprite.removeFromParent()
    } // die()
    
    
    
    
    ////////////////////
    // Update
    ////////////////////
    public func update(cycle: Int)
    {
        if UPDATECYCLE==cycle
        {
            // Simple Follow logic - target player
 
            // get direction to player
            let dx=game!.player!.playerSprite!.position.x - bodySprite.position.x
            let dy=game!.player!.playerSprite!.position.y - bodySprite.position.y
            let angle=atan2(dy,dx)
            // Compute distance to player
            playerDist=hypot(dy, dx)
            
            
            // Turn towards player
            if isPursuing
            {
                turnToAngle=angle
                turnTo(pAngle: angle)
            }

            
        } // if it's our time to update
        if playerDist > VISIONDIST
        {
            isPursuing=false
        }
        else
        {
            isPursuing=true
        }
        
        // move towards player
        if playerDist > pursueRange && isPursuing
        {
            let moveDX=cos(bodySprite.zRotation)*moveSpeed
            let moveDY=sin(bodySprite.zRotation)*moveSpeed
            bodySprite.position.x += moveDX
            bodySprite.position.y += moveDY
        } // pursue player
    } // update()
    
} // class EntityClass


