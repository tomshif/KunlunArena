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
    
    let BASEREGEN:CGFloat=1.0
    
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
        
        let tempGhostDodge=GhostDodgeTalentClass(theGame: game!)
        playerTalents.append(tempGhostDodge)
        
        equippedWeapon=BaseInventoryClass(game: game!)
        
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
    
    public func resetStats()
    {
        playerLevel=equippedWeapon!.iLevel
        strength=CGFloat(playerLevel*15+5)
        quickness=CGFloat(playerLevel*15+5)
        wisdom=CGFloat(playerLevel*15+5)
        maxMana=CGFloat(playerLevel*15+5)
        maxHealth=CGFloat(playerLevel*15+5)
        moveSpeed=7.5
        manaRegen=BASEREGEN
        healthRegen=BASEREGEN
        
        // TEMP - For now, set player level equal to the equipped weapon level

    }
    
    public func equipRefresh()
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
            healthRegen = BASEREGEN + equippedWeapon!.statsMod/100
        }
        else if equippedWeapon!.effects % suffixEffects.MANAREGEN == 0
        {
            manaRegen = BASEREGEN + equippedWeapon!.statsMod/100
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
                manaRegen = BASEREGEN + equippedWeapon!.statsMod/100
               }
        else if equippedWeapon!.effects % suffixEffects.HEALTHREGEN == 0
               {
                healthRegen = BASEREGEN + equippedWeapon!.statsMod/100
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
        
    }
    public func update()
    {
        updateTalents()
        checkActions()
        moveTo()
        healthRe()
        manaRe()
        
        // test
        //print("Mana: \(game!.player!.mana)")
        //print("Health:\(game!.player!.health)")
        //print("Stats Mod: \(equippedWeapon!.statsMod)")
    } // update()
    
    
} // PlayerClass
