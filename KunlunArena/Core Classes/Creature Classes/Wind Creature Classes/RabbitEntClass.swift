//
//  RabbitEntClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 1/29/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class RabbitEntClass:EntityClass
{
    var rabbitSoundAction=SKAction.playSoundFileNamed("quickBite.mp3", waitForCompletion: true)
    
  override init(theGame: GameClass, id: Int)
  {
      super.init(theGame: theGame, id: id)
      spriteNamePrefix="rabbit"
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
    leftSprite.isHidden=true
    rightSprite.isHidden=true
    
    
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
      
    entColor=NSColor(calibratedRed: random(min: 0.3, max: 0.5), green: random(min: 0.6, max: 0.8), blue: random(min: 0.1, max: 0.4), alpha: 1.0)
    
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor
 

    
  } // init scene/ID


    override func attack() {
               
         
              if !bodySprite.hasActions()
              {
                  bodySprite.run(rabbitSoundAction)
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
    
    
    
    
}// class RabbitEntClass
