//
//  EnemyMeleeClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 1/29/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyMeleeClass:EnemySkillClass
{
    override init(theGame: GameClass, ent: EntityClass)
    {
        super.init(theGame: theGame, ent: ent)
        
        manaCost=0
        COOLDOWN=0.5
        lengthActive=0
        tier=0
        
        
    } // init (scene)
    
    override func doSkill()
    {
        // Pick a spot in front of the enemy and see if player is there
        
        let dx=cos(entity!.bodySprite.zRotation)*100+entity!.bodySprite.position.x
        let dy=sin(entity!.bodySprite.zRotation)*100+entity!.bodySprite.position.y
        
        for node in scene!.nodes(at: CGPoint(x: dx, y: dy))
        {
            if node.name != nil
            {
                if node.name! == "playerSprite"
                {
                    // Do damage to the player (coming soon)
                    print("Entity Level: \(entity!.entLevel)")
                    print("Base Damage: \(entity!.baseDamage)")
                    print("Hit player for          \(entity!.currentDamage) damage.")
                game!.player!.takeDamage(amount: entity!.currentDamage)
                } // if we hit player
            }// if not nil
        } // for each node
        
        // update our cooldown
        lastUse=NSDate()
        
        // apply the damage
        

        
    } // doSkill()
    
} // EnemyMeleeClass

