//
//  PigEntClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 1/24/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class PigEntClass:EntityClass
{
    var pigSoundAction=SKAction.playSoundFileNamed("shortOink", waitForCompletion: true)
    
  override init(theGame: GameClass, id: Int)
  {
      super.init(theGame: theGame, id: id)
      spriteNamePrefix="pig"
      headNum=3
      bodyNum=3
      tailNum=3

      headID=Int(random(min: 0, max: CGFloat(headNum)-0.000000001))
      bodyID=Int(random(min: 0, max: CGFloat(bodyNum)-0.000000001))
      tailID=Int(random(min: 0, max: CGFloat(tailNum)-0.000000001))
      let wingID=Int(random(min:1, max: CGFloat(leftNum)-0.000000001))
      leftID=wingID
      rightID=wingID
    
      headSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Head0\(headID)")
      bodySprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Body0\(bodyID)")
      tailSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Tail0\(tailID)")
      leftSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Left0(leftID)")
      rightSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Right0(rightID)")
      bodySprite.setScale(spriteScale)
    
    //
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
      
    entColor=NSColor(calibratedRed: random(min: 1, max: 1.0), green: random(min: 1, max: 1.0), blue: random(min: 1, max: 1.0), alpha: 1.0)
    
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor

    if entLevel >= 2
    {
        currentDamage=random(min: 3.0, max: 5.0)
    }//entLevel >= 2
    
    if entLevel == 1
    {
        currentDamage=random(min: 2.0, max: 3.0)
    }//entLevel == 1

    if  spriteScale >= 2.5
    {
        moveSpeed=random(min: 5.5, max: 7.5)
    }// moveSpeed
      
    if  spriteScale <= 2.0
    {
        moveSpeed=random(min: 6.5, max: 9.5)
    }//moveSpeed
    
    
    
    
  } // init scene/ID

    override func attack() {
            
      
           if !bodySprite.hasActions()
           {
               bodySprite.run(pigSoundAction)
           }
           if skillList[1].getCooldown() < 0
           {
               skillList[1].doSkill()
           }
           else if skillList[0].getCooldown() < 0
           {
               skillList[0].doSkill()
           }
       }//attack
    
    
}// class PigEntClass

