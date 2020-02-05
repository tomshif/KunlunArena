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
    var isInAttackMode:Bool=false
    
    var equippedWeapon:BaseInventoryClass?
    
    var playerTalents=[PlayerTalentClass]()
    var activeTalents=[PlayerTalentClass]()
    
    // Player stats
    var playerLevel:Int=1
    var strength:CGFloat=20
    var quickness:CGFloat=20
    var wisdom:CGFloat=20
    var mana:CGFloat=20
    var health:CGFloat=20
    var manaRegen:CGFloat=0.25
    var healthRegen:CGFloat=0.25
    var critChance:CGFloat=5.0
    var damageReduction:CGFloat=0
    var moveSpeed:CGFloat=10
    var maxHealth:CGFloat=20
    var maxMana:CGFloat=20
    var experienceGain:CGFloat=0
    var baseExUp:CGFloat=1000
    var experienceMelee:CGFloat=0
    var experienceMartial:CGFloat=0
    var experienceBows:CGFloat=0
    var experienceAncester:CGFloat=0
    var experienceMechanical:CGFloat=0
    var experienceAlchemy:CGFloat=0
    var meleeLv:Int=0
    var martialLv:Int=0
    var bowsLv:Int=0
    var ancesterLv:Int=0
    var mechanicaLv:Int=0
    var alchemyLv:Int=0

    var globalCooldown:CGFloat=0.3
    var lastAction=NSDate()
    
    
    
    let BASEREGENMANA:CGFloat=3
    let BASEREGENHEALTH:CGFloat=2.0
    
    var currentDamage:CGFloat=5.0 // This is updated each time the player changes gear or levels up.
    
    init()
    {
        
    } // init (default)
    
    
    
    
    init(theGame:GameClass)
    {
        game=theGame
        
        // initialize talents
        // 0
        let tempMelee=MeleeAttackClass(theGame: game!)
        playerTalents.append(tempMelee)
        
        // 1
        // TO DO - Dash needs to be moved to 2 and ranged needs to be put at 1
        let tempDash=DashTalentClass(theGame: game!)
        playerTalents.append(tempDash)
        
        // 2
        let tempLightning=SwordsOfLightningTalentClass(theGame: game!)
        playerTalents.append(tempLightning)
        
        // 3 - Temp
        let tempFireBreath=FireBreathTalentClass(theGame: game!)
        playerTalents.append(tempFireBreath)
        
        // 4
        let tempGhostDodge=GhostDodgeTalentClass(theGame: game!)
        playerTalents.append(tempGhostDodge)
        
        // 5
        let tempCherryBomb=CherryBombTalentClass(theGame: game!)
        playerTalents.append(tempCherryBomb)
        
        // 6 Anger Issues
        let tempAnger=AngerIssuesTalentClass(theGame: game!)
        playerTalents.append(tempAnger)
        
        // 7 Blooming Flower
        let tempFlower=BloomingFlowerTalentClass(theGame: game!)
        playerTalents.append(tempFlower)
        
        equippedWeapon=BaseInventoryClass(game: game!, level: 1)
        resetStats()
        equipRefresh()
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
    
    
    public func healthRe()
    {
        if health<maxHealth
        {
            health+=healthRegen/60
        }
        else{
            health=maxHealth
        }
    }
    
    public func manaRe()
    {
        if mana<maxMana
        {
            mana+=manaRegen/60
        }
        else{
            mana=maxMana
        }
    }
    private func checkActions()
    {
        isPlayAction=playerSprite!.hasActions()
    } // checkActions
    
    public func updateTalents()
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
    
    internal func dropLoot(loot: BaseInventoryClass)
    {
        // This function drops a specific piece of loot. Currently, it drops the equipped weapon when the player picks up another weapon.
        // Will be used from the equipment selection screen for the player to drop loot
        // Also will be called when the player tries to pick up loot when they are at the max number of items for that type so that there is a visual of the loot being tossed back up in the air (and probably a sound effect along with it).


            let lootSprite=SKSpriteNode(imageNamed: loot.iconString)
            lootSprite.name=String(format: "loot%05d",game!.lootCounter)
            
            lootSprite.position=playerSprite!.position
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
            lootGlow.color=loot.itemLevelColor
            
            
            // add to the loot list
            game!.lootCounter+=1
            game!.lootList.append(loot)
            
        
    } // dropLoot()
    
    public func getGlobalCooldownRatio() -> CGFloat
    {
        let cooldown = globalCooldown -  CGFloat(-lastAction.timeIntervalSinceNow) 
        
        return cooldown/globalCooldown
        
    } // getGlobalCooldownRatio()
    
    public func resetStats()
    {
        playerLevel=equippedWeapon!.iLevel
        strength=CGFloat(playerLevel*5+15)
        quickness=CGFloat(playerLevel*5+15)
        wisdom=CGFloat(playerLevel*5+15)
        maxMana=CGFloat(playerLevel*5+35)
        maxHealth=CGFloat(playerLevel*5+35)
        moveSpeed=7.5
        manaRegen=BASEREGENMANA
        healthRegen=BASEREGENHEALTH
        
        // TEMP - For now, set player level equal to the equipped weapon level

    } // resetStats()
    
    public func takeDamage(amount: CGFloat)
    {

        print("Health: \(health)")
        health -= amount*(1-damageReduction)
        print("\(amount) reduced to \(amount*(1-damageReduction))")
        
        // create a flash effect to indicate it got hit
        playerSprite!.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.5, duration: 0.1), SKAction.fadeAlpha(to: 1.0, duration: 0.1)]))
        game!.floatText!.damageLabel(amount: amount*(1-damageReduction), player: self)
        // create blood splatter
        for _ in 1...5
        {
            let tempBlood=SKSpriteNode(imageNamed: "bloodSplatter")
            tempBlood.position=playerSprite!.position
            tempBlood.zPosition=10
            tempBlood.zRotation=random(min: 0, max: CGFloat.pi*2)
            let distance=random(min: 2, max: 100)
            let angle=random(min: 0, max: CGFloat.pi*2)
            let adx=cos(angle)*distance
            let ady=sin(angle)*distance
            tempBlood.run(SKAction.sequence([SKAction.move(by: CGVector(dx: adx, dy: ady), duration: 0.4), SKAction.wait(forDuration: 2.0), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
            tempBlood.name="bloodSplatter"
            game!.scene!.addChild(tempBlood)
        } // for
        
            

    } // takeDamage()
    
    public func receiveHealing(amount: CGFloat)
    {

        health += amount

        
        // create a flash effect to indicate it got hit
        game!.floatText!.healLabel(amount: amount, player: self)
        
    } // receiveHealing
    
    public func equipRefresh()
    {
        if equippedWeapon!.rarity > 1
        {
            if equippedWeapon!.effects % suffixEffects.STRENGTH == 0
            {
                strength = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
            }
            else if equippedWeapon!.effects % suffixEffects.QUICKNESS == 0
            {
                quickness = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
            }
            else if equippedWeapon!.effects % suffixEffects.WISDOM == 0
            {
                wisdom = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
            }
            else if equippedWeapon!.effects % suffixEffects.HEALTH == 0
            {
                maxHealth = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
            }
            else if equippedWeapon!.effects % suffixEffects.MANA == 0
            {
                maxMana = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
            }
            else if equippedWeapon!.effects % suffixEffects.HEALTHREGEN == 0
            {
                healthRegen = BASEREGENHEALTH + equippedWeapon!.statsMod/100
            }
            else if equippedWeapon!.effects % suffixEffects.MANAREGEN == 0
            {
                manaRegen = BASEREGENMANA + equippedWeapon!.statsMod/100
            }
            else if equippedWeapon!.effects % suffixEffects.MOVESPEED == 0
            {
                moveSpeed = 7.5 + equippedWeapon!.statsMod/100
            }
            else if equippedWeapon!.effects % suffixEffects.CRITICAL == 0
            {
                critChance = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
            }
            
            
            if equippedWeapon!.effects % suffixEffects.CRITICAL == 0
            {
                critChance = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
            }
            else if equippedWeapon!.effects % suffixEffects.MOVESPEED == 0
                   {
                    moveSpeed = 7.5 + equippedWeapon!.statsMod/100
                   }
            else if equippedWeapon!.effects % suffixEffects.MANAREGEN == 0
                   {
                    manaRegen = BASEREGENMANA + equippedWeapon!.statsMod/100
                   }
            else if equippedWeapon!.effects % suffixEffects.HEALTHREGEN == 0
                   {
                    healthRegen = BASEREGENHEALTH + equippedWeapon!.statsMod/100
                   }
            else if equippedWeapon!.effects % suffixEffects.MANA == 0
                 {
                     maxMana = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
                 }
            else if equippedWeapon!.effects % suffixEffects.HEALTH == 0
            {
                maxHealth = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
            }
            else if equippedWeapon!.effects % suffixEffects.WISDOM == 0
                   {
                       wisdom = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
                   }
            else if equippedWeapon!.effects % suffixEffects.QUICKNESS == 0
                   {
                       quickness = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
                   }
            else if equippedWeapon!.effects % suffixEffects.STRENGTH == 0
                   {
                       strength = CGFloat(15 + playerLevel*5) + equippedWeapon!.statsMod
                   }
        } // if better than common quality
    } // equipRefresh
    public func receiveEX()
    {
        if  game!.player!.equippedWeapon!.talentType == TalentBranchList.melee
        {
            experienceMelee+=experienceGain*0.8
            experienceMartial+=experienceGain*0.1
            experienceBows+=experienceGain*0.025
            experienceAlchemy+=experienceGain*0.025
            experienceMechanical+=experienceGain*0.025
            experienceAncester+=experienceGain*0.025
        }
        if game!.player!.equippedWeapon!.talentType == TalentBranchList.martial
        {
            experienceMelee+=experienceGain*0.1
                       experienceMartial+=experienceGain*0.8
                       experienceBows+=experienceGain*0.025
                       experienceAlchemy+=experienceGain*0.025
                       experienceMechanical+=experienceGain*0.025
                       experienceAncester+=experienceGain*0.025
        }
        if game!.player!.equippedWeapon!.talentType == TalentBranchList.bow
        {
            experienceMelee+=experienceGain*0.025
                                  experienceMartial+=experienceGain*0.025
                                  experienceBows+=experienceGain*0.8
                                  experienceAlchemy+=experienceGain*0.1
                                  experienceMechanical+=experienceGain*0.025
                                  experienceAncester+=experienceGain*0.025
        }
        if game!.player!.equippedWeapon!.talentType == TalentBranchList.mechanical
               {
                   experienceMelee+=experienceGain*0.025
                                         experienceMartial+=experienceGain*0.025
                                         experienceBows+=experienceGain*0.1
                                         experienceAlchemy+=experienceGain*0.025
                                         experienceMechanical+=experienceGain*0.8
                                         experienceAncester+=experienceGain*0.025
               }
        if game!.player!.equippedWeapon!.talentType == TalentBranchList.alchemy
                      {
                          experienceMelee+=experienceGain*0.025
                                                experienceMartial+=experienceGain*0.025
                        experienceBows+=experienceGain*0.025
                                                experienceAlchemy+=experienceGain*0.8
                                experienceMechanical+=experienceGain*0.025
                                experienceAncester+=experienceGain*0.1
                      }
        if game!.player!.equippedWeapon!.talentType == TalentBranchList.ancestor
                             {
                                 experienceMelee+=experienceGain*0.025
                            experienceMartial+=experienceGain*0.025
                               experienceBows+=experienceGain*0.025
                                experienceAlchemy+=experienceGain*0.1
                                       experienceMechanical+=experienceGain*0.025
                                       experienceAncester+=experienceGain*0.8
                             }
    }
    public func LevelUp()
    {
        if experienceAncester>=baseExUp
        {
            experienceAncester-=baseExUp
            ancesterLv+=1
        }
        if experienceMechanical>=baseExUp
        {
            experienceAncester-=baseExUp
            mechanicaLv+=1
        }
        if experienceAlchemy>=baseExUp
        {
            experienceAncester-=baseExUp
            ancesterLv+=1
        }
        if experienceBows>=baseExUp
        {
            experienceBows-=baseExUp
            bowsLv+=1
        }
        if experienceMartial>=baseExUp
        {
            experienceMartial-=baseExUp
            martialLv+=1
        }
        if experienceMelee>=baseExUp
        {
            experienceMelee-=baseExUp
            meleeLv+=1
        }
    }
    
    public func update()
    {
        checkActions()
        moveTo()
        healthRe()
        manaRe()
        LevelUp()
        receiveEX()
        
        
        // test
        //print("Mana: \(game!.player!.mana)")
        //print("Health:\(game!.player!.health)")
        //print("Stats Mod: \(equippedWeapon!.statsMod)")
    } // update()
    
    
    
} // PlayerClass
