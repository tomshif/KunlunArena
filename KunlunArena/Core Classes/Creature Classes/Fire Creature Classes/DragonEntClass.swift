//
//  DragonEntClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 1/29/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class DragonEntClass:EntityClass
{
  override init(theGame: GameClass, id: Int)
  {
      super.init(theGame: theGame, id: id)
      spriteNamePrefix="dragon"
      headNum=3
      bodyNum=3
      tailNum=3

      headID=Int(random(min: 0, max: CGFloat(headNum)-0.000000001))
      bodyID=Int(random(min: 0, max: CGFloat(bodyNum)-0.000000001))
      tailID=Int(random(min: 0, max: CGFloat(tailNum)-0.000000001))
      let wingID=Int(random(min: 0, max: CGFloat(tailNum)-0.000000001))
      rightID=wingID
    leftID=wingID
    
      headSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Head0\(headID)")
      bodySprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Body0\(bodyID)")
      tailSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Tail0\(tailID)")
    leftSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Left0\(leftID)")
    rightSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Right0\(rightID)")
      spriteScale=random(min: 1.5, max: 3.5)
      bodySprite.setScale(spriteScale)
    
    
    moveSpeed=random(min: 5.0, max: 5.5)
    TURNRATE=random(min: 0.8, max: 0.8)
    attackRange=random(min: 50, max: 150)
    VISIONDIST=random(min: 500, max: 500)
    
    if attackRange > 45
    {
        pursueRange=attackRange*2
    }
    else
    {
        pursueRange=attackRange
    }
      
    let entColor=NSColor(calibratedRed: random(min: 0.1, max: 1.0), green: random(min: 0.1, max: 1.0), blue: random(min: 0.1, max: 1.0), alpha: 1.0)
    
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor
 


    if entLevel >= 2
    {
        currentDamage=random(min: 4.0, max: 6.0)
    }//entLevel >= 2
        
    if entLevel == 1
    {
        currentDamage=random(min: 1.0, max: 3.0)
    }//entLevel == 1
    
    if  spriteScale >= 2.5
    {
        moveSpeed=random(min: 4.5, max: 6.5)
    }// moveSpeed
    
    if  spriteScale <= 2.0
    {
        moveSpeed=random(min: 5.5, max: 8.5)
    }//moveSpeed
    
    
    
  } // init scene/ID


    
    
    
    
}// class DragonEntClass
