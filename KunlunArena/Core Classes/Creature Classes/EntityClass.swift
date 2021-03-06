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
    var spriteNamePrefix:String="dragon"
    
    // the number of possible combinations for each sprite part.
    var headNum:Int=0
    var bodyNum:Int=0
    var tailNum:Int=0
    var leftNum:Int=0
    var rightNum:Int=0
    
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
    var healthBar=SKSpriteNode()
    
    var spriteScale:CGFloat=1.0
    var entColor=NSColor()
    
    
    
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
    var MELEERANGE:CGFloat=100
    var statusEffect:Int=0
    
    
    // Entity Stats
    var entLevel:Int=1
    var health:CGFloat=10
    var maxHealth:CGFloat=10
    var mana:CGFloat=20
    var baseDamage:CGFloat=1.0
    var currentDamage:CGFloat=0
    var damageReduction:CGFloat=0.05 // Modifier applied to incoming damage
    
    var activeSkillList=[EnemySkillClass]()
    var skillList=[EnemySkillClass]()
    
    
    init()
    {
        name="Test"
        headNum=0
        bodyNum=0
        tailNum=0
        headSprite=SKSpriteNode(imageNamed: "head")
        bodySprite=SKSpriteNode(imageNamed: "body")
        
    } // init() - default
    
    init(theGame: GameClass, id: Int)
    {
        game=theGame
        scene=theGame.scene!
        
        name=String(format:"Ent%5d",id)
        entID=id
        UPDATECYCLE=entID % 4
        headNum=0
        bodyNum=0
        tailNum=0
        leftNum=0
        rightNum=0
        headSprite=SKSpriteNode(imageNamed: "\(spriteNamePrefix)Head00")
        bodySprite=SKSpriteNode(imageNamed: "\(spriteNamePrefix)Body00")
        tailSprite=SKSpriteNode(imageNamed: "\(spriteNamePrefix)Tail00")
        rightSprite=SKSpriteNode(imageNamed: "\(spriteNamePrefix)Right00")
        leftSprite=SKSpriteNode(imageNamed: "\(spriteNamePrefix)Left00")
        bodySprite.colorBlendFactor=1.0
        headSprite.colorBlendFactor=1.0
        tailSprite.colorBlendFactor=1.0
        leftSprite.colorBlendFactor=1.0
        rightSprite.colorBlendFactor=1.0
        healthBar=SKSpriteNode(imageNamed: "entHealthBar")
        healthBar.setScale(4.0)
        game!.scene!.addChild(healthBar)
        
        entColor=NSColor(calibratedRed: random(min: 1, max: 1.0), green: random(min: 0, max: 1), blue: random(min: 0, max: 1), alpha: 1.0)
        bodySprite.color=entColor
        headSprite.color=entColor
        tailSprite.color=entColor
        leftSprite.color=entColor
        rightSprite.color=entColor
        

        scene!.addChild(bodySprite)

        
        bodySprite.addChild(headSprite)
        bodySprite.addChild(tailSprite)
        bodySprite.addChild(rightSprite)
        bodySprite.addChild(leftSprite)

        headSprite.position.x=bodySprite.size.width
        
        tailSprite.position.x = -bodySprite.size.width
        leftSprite.position.y = bodySprite.size.height
        rightSprite.position.y = -bodySprite.size.height


        bodySprite.name=String(format:"entBody%5d",id)
        headSprite.name=String(format:"entHead%5d",id)
        tailSprite.name=String(format:"entTail%5d",id)
        bodySprite.zPosition=30
        headSprite.zPosition=30
        tailSprite.zPosition=30
        leftSprite.zPosition=30
        rightSprite.zPosition=30
        healthBar.zPosition=40

        bodySprite.physicsBody=SKPhysicsBody(circleOfRadius: bodySprite.size.width)
        bodySprite.physicsBody!.categoryBitMask=BODYBITMASKS.ENEMY
        bodySprite.physicsBody!.collisionBitMask=BODYBITMASKS.WALL | BODYBITMASKS.ENEMY | BODYBITMASKS.PLAYER
       
        bodySprite.physicsBody!.friction=0.5
        bodySprite.texture!.filteringMode=SKTextureFilteringMode.nearest
        headSprite.texture!.filteringMode=SKTextureFilteringMode.nearest
        tailSprite.texture!.filteringMode=SKTextureFilteringMode.nearest
       
        leftSprite.texture!.filteringMode=SKTextureFilteringMode.nearest
        rightSprite.texture!.filteringMode=SKTextureFilteringMode.nearest
        bodySprite.physicsBody!.affectedByGravity=false
        
        // Setup entity stats
        currentDamage=baseDamage*CGFloat(entLevel)
        
        moveSpeed=random(min: 5.5, max: 10.5)
        TURNRATE=random(min: 0.9, max: 0.9)
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
        
        // Set Entity Stats

        let variance=Int(random(min: -3, max: 3))
        entLevel=game!.player!.playerLevel+variance
        if entLevel <= 0
        {
            entLevel=1
        }
        print("EntLevel = \(entLevel)")
        health=CGFloat(entLevel)*35+25
        maxHealth=health
        // setup skills
        setupSkills()
        
    } // init(scene)
    
    internal func setupSkills()
    {
        // 0
        let tempMelee=EnemyMeleeClass(theGame: game!, ent: self)
        skillList.append(tempMelee)
        
        // 1
        let tempBlink=EnemyBlinkClass(theGame: game!, ent: self)
        skillList.append(tempBlink)
        
        // 2
        let tempFire=EnemyFireClass(theGame: game!, ent: self)
        skillList.append(tempFire)
        
    } // setupSkills
    
    internal func updateHealthBar()
    {
        //print("updating health bar")
        if health/maxHealth > 0.98
        {
            healthBar.isHidden=true
        }
        else
        {
            healthBar.isHidden=false
            healthBar.xScale=health/maxHealth*4.0
        }
        
        healthBar.position.x = bodySprite.position.x
        healthBar.position.y = bodySprite.position.y + bodySprite.size.height
        
        
    } // updateHealthBar
    
    public func takeDamage(amount: CGFloat)
    {
        if statusEffect == SPECIALSTATUS.jade
        {
            // if we're jade, any damage causes us to splode
            
            let splode=SKEmitterNode(fileNamed: "JadeSplodeEmitter.sks")
            splode!.position = bodySprite.position
            splode!.zPosition=1500
            splode!.setScale(1.0)
            game!.scene!.addChild(splode!)
            splode!.run(SKAction.sequence([SKAction.wait(forDuration: 2.5),SKAction.removeFromParent()]))
            die()
            
        }
        else
        {
                
            game!.player!.playerDamageCount += amount
            print("Health: \(health)")
            health -= amount*(1-damageReduction)
            print("\(amount) reduced to \(amount*(1-damageReduction))")
            
            // create a flash effect to indicate it got hit
            bodySprite.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.5, duration: 0.1), SKAction.fadeAlpha(to: 1.0, duration: 0.1)]))
            game!.floatText!.damageLabel(amount: amount*(1-damageReduction), ent: self)
            // create blood splatter
            for _ in 1...5
            {
                let tempBlood=SKSpriteNode(imageNamed: "bloodSplatter")
                tempBlood.position=bodySprite.position
                tempBlood.zPosition=10
                tempBlood.zRotation=random(min: 0, max: CGFloat.pi*2)
                let distance=(random(min: 2, max: 100)+random(min: 2, max: 100))/2
                let angle=random(min: 0, max: CGFloat.pi*2)
                let adx=cos(angle)*distance
                let ady=sin(angle)*distance
                tempBlood.run(SKAction.sequence([SKAction.move(by: CGVector(dx: adx, dy: ady), duration: 0.4), SKAction.wait(forDuration: 2.0), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
                tempBlood.name="bloodSplatter"
                game!.scene!.addChild(tempBlood)
                
            } // for
            
        } // if not jade
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
        dropLoot()
        healthBar.removeFromParent()
        bodySprite.removeAllChildren()
        bodySprite.removeAllActions()
        bodySprite.removeFromParent()
        isDead=true
        game!.player!.enemyKillCount += 1
        game!.player!.receiveEX()

    } // die()
    
    public func remove()
    {
        // This function is to remove without loot dropping
        healthBar.removeFromParent()
        bodySprite.removeAllChildren()
        bodySprite.removeAllActions()
        bodySprite.removeFromParent()
        isDead=true
        
    } // remove()
    
    
    internal func dropLoot()
    {
        // This function generates a random chance to drop loot
        // Right now, the chance is high, but it will be reduced. Right now, it uses the generic (completely random) initializer, but we will be able to create a different init for the BaseInventoryClass to generate certain types/qualities/etc of loot
        let roll=random(min: 0, max: 1)
        if roll > 0.9
        {
            let temploot=BaseInventoryClass(theGame: game!, level: entLevel)
            let lootSprite=SKSpriteNode(imageNamed: temploot.iconString)
            lootSprite.name=String(format: "loot%05d",game!.lootCounter)
            
            lootSprite.position=bodySprite.position
            lootSprite.setScale(1.5)
                let flyDist=random(min: -50, max: 50)
            lootSprite.run(SKAction.sequence([SKAction.move(by: CGVector(dx: flyDist, dy: 100), duration: 0.5), SKAction.move(by: CGVector(dx: flyDist, dy: -100), duration: 0.5)]))
            lootSprite.run(SKAction.rotate(byAngle: random(min: -CGFloat.pi, max: CGFloat.pi), duration: 1.0))
            
            lootSprite.zPosition=5
            
            game!.scene!.addChild(lootSprite)
            
            let lootGlow=SKSpriteNode(imageNamed: "itemGlow")
            lootGlow.zPosition = -2
            let lootaction=SKAction.sequence([SKAction.rotate(byAngle: -CGFloat.pi/2, duration: 0.35), SKAction.rotate(byAngle: CGFloat.pi/2, duration: 0.35)])
            lootGlow.run(SKAction.repeatForever(lootaction))
            lootGlow.alpha=0.5
            let lootsparkle=SKAction.sequence([SKAction.fadeAlpha(to: 0.75, duration: 0.25), SKAction.fadeAlpha(to: 0.5, duration: 0.25)])
            lootGlow.run(SKAction.repeatForever(lootsparkle))
            lootSprite.addChild(lootGlow)
            lootGlow.colorBlendFactor=1.0
            lootGlow.color=temploot.itemLevelColor
            
            
            // add to the loot list
            game!.lootCounter+=1
            game!.lootList.append(temploot)
            
        } // if we're dropping loot
    } // dropLoot()
    
    
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
    
    internal func pursue()
    {
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
        
    } // pursue()
    
    
    internal func attack()
    {
        if skillList[2].getCooldown() < 0
        {
            skillList[2].doSkill()
        }
        else if skillList[1].getCooldown() < 0
        {
            skillList[1].doSkill()
        }
        else if skillList[0].getCooldown() < 0
        {
            skillList[0].doSkill()
        }

        
    } //atack()
    
    
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
        
        if UPDATECYCLE==cycle && !isDead && statusEffect != SPECIALSTATUS.jade
        {
            
 
            pursue()
            if playerDist <= MELEERANGE*2
            {
                attack()
            }
        } // if it's our time to update

        
        // move if pursuing
        if playerDist > pursueRange && isPursuing && !isDead && statusEffect != SPECIALSTATUS.jade
        {
            let moveDX=cos(bodySprite.zRotation)*moveSpeed
            let moveDY=sin(bodySprite.zRotation)*moveSpeed
            bodySprite.position.x += moveDX
            bodySprite.position.y += moveDY
        } // update sprite position
        
        // update healthBar
        updateHealthBar()

    } // update()
    
} // class EntityClass


