//
//  MeleeAttack.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 1/23/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//
// This is an example class of a simple melee attack that shows how to find targets from the GameClass and detect whether we have hit them.
// By default this plain melee attack will be performed by holding the space bar (which also locks the player into spot) while clicking.

import Foundation
import SpriteKit


class MeleeAttackClass:PlayerTalentClass
{
    var attackDistance:CGFloat=50
    
    override init(theGame: GameClass) {
        super.init(theGame: theGame)
        name="Attack"
        description="Standard melee attack"
        COOLDOWN=0.25 // This will actually come from the equipped weapon eventually, but for now we're hardcoding it.
    } // init(game)
    
    override func doTalent()
    {
        // To do the attack, we check a spot a set distance from the player and see if there is an entity body there. If there is, we hit it. Since entities collide with each other, there should never be more than one body there.
        
        super.doTalent()
        
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
} // MeleeAttackClass


