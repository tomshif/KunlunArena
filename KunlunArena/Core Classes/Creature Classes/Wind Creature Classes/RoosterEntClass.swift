//
//  RoosterEntClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 1/29/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class RoosterEntClass:EntityClass
{
    var roosterSoundAction=SKAction.playSoundFileNamed("scratchQuick.mp3", waitForCompletion: true)
    
  override init(theGame: GameClass, id: Int)
  {
      super.init(theGame: theGame, id: id)
      spriteNamePrefix="rooster"
      headNum=3
      bodyNum=3
      tailNum=3

      headID=Int(random(min: 0, max: CGFloat(headNum)-0.000000001))
      bodyID=Int(random(min: 0, max: CGFloat(bodyNum)-0.000000001))
      tailID=Int(random(min: 0, max: CGFloat(tailNum)-0.000000001))
      let wingID=Int(random(min: 0, max: CGFloat(tailNum)-1.000000001))
        rightID=wingID
      leftID=wingID
      
      headSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Head0\(headID)")
      bodySprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Body0\(bodyID)")
      tailSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Tail0\(tailID)")
      leftSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Left0\(leftID)")
      rightSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Right0\(rightID)")
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
      
    entColor=NSColor(calibratedRed: random(min: 0.27, max: 0.48), green: random(min: 0.27, max: 0.38), blue: random(min: 0.38, max: 0.48), alpha: 1.0)
    
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor
    leftSprite.color=entColor
    rightSprite.color=entColor


    
    
    
  } // init scene/ID


    override func attack() {
                 
           
                if !bodySprite.hasActions()
                {
                    bodySprite.run(roosterSoundAction)
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
    
    
    
}// class RoosterEntClass
