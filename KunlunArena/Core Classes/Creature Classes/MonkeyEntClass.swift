//
//  MonkeyEntClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 1/23/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//


// I'm just typing random stuff here because Xcode is stupid.


import Foundation
import SpriteKit

class MonkeyEntClass:EntityClass
{
  override init(theGame: GameClass, id: Int)
  {
      super.init(theGame: theGame, id: id)
      spriteNamePrefix="monkey"
      headNum=3
      bodyNum=3
      tailNum=3

    health = 42
      headID=Int(random(min: 0, max: CGFloat(headNum)-0.000000001))
      bodyID=Int(random(min: 0, max: CGFloat(bodyNum)-0.000000001))
      tailID=Int(random(min: 0, max: CGFloat(tailNum)-0.000000001))
      
      
      headSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Head0\(headID)")
      bodySprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Body0\(bodyID)")
      tailSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Tail0\(tailID)")
      spriteScale=random(min: 1.5, max: 3.5)
      bodySprite.setScale(spriteScale)
    
    
    moveSpeed=random(min: 5.5, max: 10.5)
    TURNRATE=random(min: 0.9, max: 0.9)
    attackRange=random(min: 25, max: 200)
    VISIONDIST=random(min: 500, max: 500)
    if attackRange > 45
    {
        pursueRange=attackRange*2
    }
    else
    {
        pursueRange=attackRange
    }
      
    let entColor=NSColor(calibratedRed: random(min: 0.3, max: 0.8), green: random(min: 0.3, max: 0.6), blue: random(min: 0.1, max: 0.3), alpha: 1.0)
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor
    
    
    
    
  } // init scene/ID
    
  
    
    
    
    
}// class MonkeyEntClass
