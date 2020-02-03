//
//  SnakeEntClass.swift
//  KunlunArena
//
//  Created by 5 - Game Design on 1/23/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class SnakeEntClass:EntityClass
{
  override init(theGame: GameClass, id: Int)
  {
      super.init(theGame: theGame, id: id)
      spriteNamePrefix="snake"
      headNum=3
      bodyNum=3
      tailNum=3

      headID=Int(random(min: 0, max: CGFloat(headNum)-0.000000001))
      bodyID=Int(random(min: 0, max: CGFloat(bodyNum)-0.000000001))
      tailID=Int(random(min: 0, max: CGFloat(tailNum)-0.000000001))
      
      
      headSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Head0\(headID)")
      bodySprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Body0\(bodyID)")
      tailSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Tail0\(tailID)")
      spriteScale=random(min: 1.5, max: 3.5)
      bodySprite.setScale(spriteScale)
    
    
    moveSpeed=random(min: 5.7, max: 10.3)
    TURNRATE=random(min: 0.8, max: 0.8)
    attackRange=random(min: 25, max: 150)
    VISIONDIST=random(min: 500, max: 500)
    
    if attackRange > 45
    {
        pursueRange=attackRange*2
    }
    else
    {
        pursueRange=attackRange
    }
      
    let entColor=NSColor(calibratedRed: random(min: 0.3, max: 0.4), green: random(min: 0.3, max: 0.6), blue: random(min: 0.1, max: 0.3), alpha: 1.0)
    
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor
    
    baseDamage=2
    health=15
    mana=30
    damageReduction=0.05
    MELEERANGE=80
    
    if spriteScale > 2.5
    {
        moveSpeed=random(min: 6.5, max: 9.0)
        baseDamage=random(min: 3.0, max: 5.0)
        health=random(min: 100.0, max: 150.0)
        mana=35
        MELEERANGE=85
    }//spriteScale > 2.5
    
    if spriteScale < 2.5
    {
        moveSpeed=random(min: 7.0, max: 10.3)
        baseDamage=random(min: 2.0, max: 3.0)
        health=random(min: 50.0, max: 100.0)
        
    }
 


    
    
    
  } // init scene/ID


    
    
    
    
}// class SnakeEntClass

