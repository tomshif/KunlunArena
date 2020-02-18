//
//  EnemyPoisonClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 2/10/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyPoisonClass:EnemySkillClass
{
    //not working dont add to game
    override init(theGame: GameClass, ent: EntityClass)
    {
        super.init(theGame: theGame, ent: ent)
        
        manaCost=17
        COOLDOWN=8
        lengthActive=10
        tier=0
    } // init
    
    override func doSkill()
    {
      
        
        // Pick a spot in front of the enemy and see if player is there
        
        let dx=cos(entity!.bodySprite.zRotation)*25+entity!.bodySprite.position.x
        let dy=sin(entity!.bodySprite.zRotation)*25+entity!.bodySprite.position.y
        
        // get distance from player to the spot
        
        let pdx = game!.player!.playerSprite!.position.x - dx
        let pdy = game!.player!.playerSprite!.position.y - dy
        let pDist=hypot(pdy, pdx)
        
        if pDist < entity!.bodySprite.size.height*2.5
        {
            game!.player!.takeDamage(amount: entity!.currentDamage)
        }
    }
    

} // class EnemyPoisonClass
