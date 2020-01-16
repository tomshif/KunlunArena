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
    var isDead:Bool=false
    var playerInSight:Bool=false
    
    var headSprite=SKSpriteNode()
    var bodySprite=SKSpriteNode()
    var tailSprite=SKSpriteNode()
    var leftSprite=SKSpriteNode()
    var rightSprite=SKSpriteNode()
    
    var moveSpeed:CGFloat=7.5
    var turnToAngle:CGFloat=0
    var attackRange:CGFloat=15
    var pursueRange:CGFloat=15
    var lastSightAngle:CGFloat=0
    
    var playerDist:CGFloat=0
    
    
    var VISIONDIST:CGFloat=500
    var UPDATECYCLE:Int=0   // This is revised based on entID % 4 to ensure even distribution of entities in update cycling
    var TURNRATE:CGFloat=0.15
    
    
    
    // Testing Variables
    

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
        UPDATECYCLE=entID % 4
        headNum=0
        bodyNum=0
        legsNum=0
        headSprite=SKSpriteNode(imageNamed: "entHead00")
        bodySprite=SKSpriteNode(imageNamed: "entBody00")
        tailSprite=SKSpriteNode(imageNamed: "entTail00")
        //bodySprite.colorBlendFactor=1.0
        //bodySprite.color=NSColor(calibratedRed: random(min: 0, max: 1.0), green: random(min: 0, max: 1), blue: random(min: 0, max: 1), alpha: 1.0)
        bodySprite.position.x=scene!.size.height/2
        bodySprite.position.y=scene!.size.width/2
        let spriteScale=random(min: 0.75, max: 2)

        scene!.addChild(bodySprite)

        
        bodySprite.addChild(headSprite)
        bodySprite.addChild(tailSprite)
        

        headSprite.position.x=bodySprite.size.width
        
        tailSprite.position.x = -bodySprite.size.width


        bodySprite.name=String(format:"entBody%5d",id)
        headSprite.name=String(format:"entHead%5d",id)
        tailSprite.name=String(format:"entTail%5d",id)
        bodySprite.zPosition=10
        headSprite.zPosition=10
        tailSprite.zPosition=10
        

        bodySprite.physicsBody=SKPhysicsBody(circleOfRadius: bodySprite.size.width)
        bodySprite.physicsBody!.categoryBitMask=BODYBITMASKS.ENEMY
        bodySprite.physicsBody!.collisionBitMask=BODYBITMASKS.WALL | BODYBITMASKS.ENEMY | BODYBITMASKS.PLAYER
        
        bodySprite.physicsBody!.affectedByGravity=false
        
        bodySprite.setScale(spriteScale)
        
        moveSpeed=random(min: 5.5, max: 10.5)
        TURNRATE=random(min: 0.5, max: 0.9)
        attackRange=random(min: 25, max: 200)
        VISIONDIST=random(min: 500, max: 500)
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
        isDead=true

    } // die()
    
    private func checkLOS(angle: CGFloat, distance: CGFloat) -> Bool
    {
        
        let rayStart = bodySprite.position
        let rayEnd = CGPoint(x: bodySprite.position.x+(distance * cos(angle)),
                             y: bodySprite.position.y+(distance * sin(angle)))

        
        let body = scene!.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)

        
        return body?.categoryBitMask == BODYBITMASKS.PLAYER
        
        
    } // checkLOS
    
    
    
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
            var angle=atan2(dy,dx)
            if angle < 0
            {
                angle+=CGFloat.pi*2
            }

            // Compute distance to player
            playerDist=hypot(dy, dx)
            
            playerInSight=checkLOS(angle: angle, distance: VISIONDIST)
            
            // Turn towards player
            if isPursuing && playerInSight
            {
                turnToAngle=angle
                turnTo(pAngle: angle)
            } // if
            
            if isPursuing && !playerInSight
            {
                turnToAngle=lastSightAngle
                turnTo(pAngle: turnToAngle)
            } // if
            
            
            if playerInSight && playerDist < VISIONDIST
            {
                isPursuing=true
                lastSightAngle=angle
            } // if
            
            if playerDist >= VISIONDIST
            {
                isPursuing=false
            }
            
            
        } // if it's our time to update

        
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


