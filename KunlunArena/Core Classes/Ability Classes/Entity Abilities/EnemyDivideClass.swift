//
//  EnemyDivideClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 2/11/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyDivideClass:EnemySkillClass
{
    //not working dont add to game
    override init(theGame: GameClass, ent: EntityClass)
    {
        super.init(theGame: theGame, ent: ent)
        
        manaCost=20
        COOLDOWN=10
        lengthActive=5
        tier=2
    } // init
    
    override func doSkill()
    {
      
        let xp:CGFloat=0
      let yp:CGFloat=0
        
       for node in game!.scene!.nodes(at: CGPoint(x: xp, y: yp))
       {
           if node.name != nil
           {
               if node.name!.contains("snake")
               {
                if entity!.health < entity!.maxHealth*0.25
                    {
                        
                        
                        if node.name!.contains("childSnake")
                        {
                          break
                        }// checking if its a child snake if not spawn a second snake else do nothing
                        
                    }// checking snake's health is 25% left
                
               } // if it's a snake
               
           } // if the name isn't nil
           
       } // for each node at the point
       
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
