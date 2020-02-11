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
    override init(theGame: GameClass, ent: EntityClass)
    {
        super.init(theGame: theGame, ent: ent)
        
        manaCost=17
        COOLDOWN=8
        lengthActive=0.3
        tier=0
    } // init
    
    override func doSkill()
    {
       
    }
    

} // class EnemyPoisonClass
