//
//  EntityClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This class is the baseclass for ALL entities (enemy mobs).
// We must very particular about sub-classes and not change any init() parameter lists in order to keep class polymorphism.
//
// We also need to be very careful about what methods are exposed and what methods are kept internal.

import Foundation
import SpriteKit

class EntityClass
{
    var scene:SKScene? // the scene is contained in the GameClass but this is just to shorten notation.
    
    var game:GameClass? // points back to the GameClass to be able to reference the player and/or other entities
    
    
    var name:String // Generated in the init based on the type and entID
    var entID:Int=0
    

    
    
    // This is the prefix for the artwork. All artwork should follow the following format:
    //
    // ent<Type>0<Single digit number>
    // for example a pig part would be
    // "entPig01"
    var spriteNamePrefix:String="pig"
    
    // the number of possible combinations for each sprite part.
    var headNum:Int=0
    var bodyNum:Int=0
    var tailNum:Int=0
    
    // These are the ID of the sprite parts used
    var headID:Int=0
    var bodyID:Int=0
    var tailID:Int=0
    var leftID:Int=0
    var rightID:Int=0
    
    // Sprites for each part
    var headSprite=SKSpriteNode()
    var bodySprite=SKSpriteNode()
    var tailSprite=SKSpriteNode()
    var leftSprite=SKSpriteNode()
    var rightSprite=SKSpriteNode()
    
    var spriteScale:CGFloat=1.0
    
    // AI related
    var moveSpeed:CGFloat=7.5
    var turnToAngle:CGFloat=0
    var attackRange:CGFloat=15
    var pursueRange:CGFloat=15
    var lastSightAngle:CGFloat=0
    var playerDist:CGFloat=0
    var isTurning:Bool=false
    var isPursuing:Bool=false
    var isDead:Bool=false
    var playerInSight:Bool=false
    var TURNRATE:CGFloat=0.15
    var VISIONDIST:CGFloat=500
    var UPDATECYCLE:Int=0   // This is revised based on entID % 4 to ensure even distribution of entities in update cycling
    
    // Entity Stats
    var health:CGFloat=10;
    var damageReduction:CGFloat=0.05; // Modifier applied to incoming damage
    
    
    

    
    init()
    {
        name="Test"
        headNum=0
        bodyNum=0
        tailNum=0
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
        tailNum=0
        headSprite=SKSpriteNode(imageNamed: "\(spriteNamePrefix)Head00")
        bodySprite=SKSpriteNode(imageNamed: "\(spriteNamePrefix)Body00")
        tailSprite=SKSpriteNode(imageNamed: "\(spriteNamePrefix)Tail00")
        bodySprite.colorBlendFactor=1.0
        headSprite.colorBlendFactor=1.0
        tailSprite.colorBlendFactor=1.0
        bodySprite.lightingBitMask=1
        tailSprite.lightingBitMask=1
        headSprite.lightingBitMask=1
        bodySprite.shadowCastBitMask=1
        
        let entColor=NSColor(calibratedRed: random(min: 1, max: 1.0), green: random(min: 0, max: 1), blue: random(min: 0, max: 1), alpha: 1.0)
        bodySprite.color=entColor
        headSprite.color=entColor
        tailSprite.color=entColor
        bodySprite.position.x=scene!.size.height/2
        bodySprite.position.y=scene!.size.width/2
        

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
        bodySprite.texture!.filteringMode=SKTextureFilteringMode.nearest
        headSprite.texture!.filteringMode=SKTextureFilteringMode.nearest
        tailSprite.texture!.filteringMode=SKTextureFilteringMode.nearest
        bodySprite.physicsBody!.affectedByGravity=false
        
        
        
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
    
    public func takeDamage(amount: CGFloat)
    {
        health -= amount*(1-damageReduction)
        print("\(amount) reduced to \(amount*(1-damageReduction))")
        
        // create a flash effect to indicate it got hit
        bodySprite.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.5, duration: 0.1), SKAction.fadeAlpha(to: 1.0, duration: 0.1)]))
        
        // create blood splatter
        for _ in 1...5
        {
            let tempBlood=SKSpriteNode(imageNamed: "bloodSplatter")
            tempBlood.position=bodySprite.position
            tempBlood.zPosition=15
            tempBlood.zRotation=random(min: 0, max: CGFloat.pi*2)
            tempBlood.run(SKAction.sequence([SKAction.move(by: CGVector(dx: random(min: -100, max: 100), dy: random(min: -100, max: 100)), duration: 0.4), SKAction.wait(forDuration: 2.0), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
            tempBlood.name="bloodSplatter"
            game!.scene!.addChild(tempBlood)
        } // for
        
    } // takeDamage()
     
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
    
    internal func checkLOS(angle: CGFloat, distance: CGFloat) -> Bool
    {
        // Cast a ray to see if any physics blocks obstruct our view
        let rayStart = bodySprite.position
        let rayEnd = CGPoint(x: bodySprite.position.x+(distance * cos(angle)),
                             y: bodySprite.position.y+(distance * sin(angle)))

        
        let body = scene!.physicsWorld.body(alongRayStart: rayStart, end: rayEnd)

        // return true if ray is unobstructed to player, false in all other cases
        return body?.categoryBitMask == BODYBITMASKS.PLAYER
        
        
    } // checkLOS
    
    
    
    ////////////////////
    // Update
    ////////////////////
    public func update(cycle: Int)
    {
        // First, let's check our health to see if we should die
        if health <= 0
        {
            die()
        }
        
        if UPDATECYCLE==cycle && !isDead
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
            
            // Check if we can see the player
            playerInSight=checkLOS(angle: angle, distance: VISIONDIST)
            
            // Turn towards player
            if isPursuing && playerInSight && !isDead
            {
                turnToAngle=angle
                turnTo(pAngle: angle)
            } // if
            
            if isPursuing && !playerInSight && !isDead
            {
                turnToAngle=lastSightAngle
                turnTo(pAngle: turnToAngle)
            } // if
            
            
            if playerInSight && playerDist < VISIONDIST && !isDead
            {
                isPursuing=true
                lastSightAngle=angle
            } // if
            
            if playerDist >= VISIONDIST && !isDead
            {
                isPursuing=false
            }
            
            
        } // if it's our time to update

        
        // move towards player
        if playerDist > pursueRange && isPursuing && !isDead
        {
            let moveDX=cos(bodySprite.zRotation)*moveSpeed
            let moveDY=sin(bodySprite.zRotation)*moveSpeed
            bodySprite.position.x += moveDX
            bodySprite.position.y += moveDY
        } // pursue player
        

    } // update()
    
} // class EntityClass


