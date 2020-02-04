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
        description="Drain the energy from the enemy and feast on the energy to regen health"
        COOLDOWN=0.15
        isActive = false
        
    } // init(game)
    
    override func doTalent()
    {
        super.doTalent()
        // To do the attack, we check a spot a set distance from the player and see if there is an entity body there. If there is, we hit it. Since entities collide with each other, there should never be more than one body there.
        
        isActive = true
        
        // First we queue up an SKAction for our attack animation
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
        
        // reset cooldown timer
        lastUse=NSDate()
        
    } // doTalent()
    
    override func updateTalent()
    {
        
        
    }//update talent
    
    override func removeTalent()
    {
        isActive = false
    }//remove talent
    
} // VampireAttackClass
