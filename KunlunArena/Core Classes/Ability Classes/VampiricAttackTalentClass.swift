//
//  VampiricAttack.swift
//  KunlunArena
//
//  Created by Michael Ramirez on 2/3/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class VampiricAttackTalentClass:PlayerTalentClass
{
    var attackDistance:CGFloat=50
    
    override init(theGame: GameClass) {
        super.init(theGame: theGame)
        name="VampireAttack"
        description="Summon an uncotroable vampire spirit that attacks the enemys and drains there health"
        COOLDOWN=15
        isActive = false
        lengthActive=10
        manaCost=5
        iconName = "vampireAttackTalentIcon"
    } // init(game)
    
    override func doTalent()
    {
        super.doTalent()
        // To do the attack, we check a spot a set distance from the player and see if there is an entity body there. If there is, we hit it. Since entities collide with each other, there should never be more than one body there.
        isActive = true
        
        
        game!.player!.playerTalents[0].COOLDOWN=0.2
        
        
        let vampireEffect = SKEmitterNode(fileNamed: "VampiricEmmiter.sks")
        vampireEffect!.name="ghostTalentEffect"
        game!.player!.playerSprite!.addChild(vampireEffect!)
        
        
        
        vampireEffect!.zPosition = 200
        vampireEffect!.alpha=1
        vampireEffect!.run(SKAction.sequence([SKAction.wait(forDuration: 4),SKAction.fadeOut(withDuration: 1.0), SKAction.removeFromParent()]))
        
        
        
        // reset cooldown timer
        lastUse=NSDate()
        
    } // doTalent()
    
    override func updateTalent()
    {
        let attackSeq=SKAction.sequence([SKAction.scale(to: 1.5, duration: 0.1), SKAction.scale(to: 1.0, duration: 0.1)])
        game!.player!.playerSprite!.run(attackSeq)
        
        // Next, get the dx and dy of the spot that we're checking. We have to offset our position by the player's position.
        let dx=cos(game!.player!.playerSprite!.zRotation)*attackDistance+game!.player!.playerSprite!.position.x
        let dy=sin(game!.player!.playerSprite!.zRotation)*attackDistance+game!.player!.playerSprite!.position.y
        
        // Next we check that spot in the scene to see if any sprite name contains the word body or head
        var found=false
        for node in game!.scene!.nodes(at: CGPoint(x: dx, y: dy))
        {
            if node.name != nil
            {
                if node.name!.contains("Body") || node.name!.contains("Head")
                {
                    // We have hit a target so we apply damage to the target
                    // But we need to find the actual entity in our entList
                    let thisEnt=node.name!
                    
                    for entity in game!.entList
                    {
                        if thisEnt == entity.bodySprite.name! || thisEnt == entity.headSprite.name!
                        {
                            // we have found our entity, so we apply the damage based on the player's current damage
                            entity.takeDamage(amount: game!.player!.equippedWeapon!.iLevelMod * game!.player!.equippedWeapon!.modLevel)
                            
                            let totalHealAmount = game!.player!.equippedWeapon!.modLevel*CGFloat(game!.player!.equippedWeapon!.iLevel)*game!.player!.wisdom*0.05
                            
                            game!.player!.receiveHealing(amount: totalHealAmount)
                            
                            found=true
                            break
                        } // if
                    } // for
                    
                    
                } // if we hit something
            } // if the name isn't nil
            if found
            {
                break
            }
        } // for each node in the scene
        
    }//update talent
    
    override func removeTalent()
    {
        game!.player!.playerTalents[0].COOLDOWN=0.25
        isActive = false
    }//remove talent
    
} // VampireAttackClass
