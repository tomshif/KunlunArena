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
    var monkeySoundAction=SKAction.playSoundFileNamed("monkey.mp3", waitForCompletion: true)
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
    leftSprite.isHidden=true
    rightSprite.isHidden=true
    
    
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
      
    entColor=NSColor(calibratedRed: random(min: 0.17, max: 0.49), green: random(min: 0.14, max: 0.2), blue: random(min: 0.14, max: 0.2), alpha: 1.0)
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor
    
    if entLevel >= 2
           {
               moveSpeed=random(min: 7.0, max: 10.0)
               currentDamage=random(min: 3.0, max: 5.0)
               mana=35
               MELEERANGE=85
               
           }//entLevel >= 2
           
           if entLevel == 1
           {
               moveSpeed=random(min: 5.5, max: 9.0)
               currentDamage=random(min: 2.0, max: 3.0)
               
           }//entLevel == 1
    
    
  } // init scene/ID
    
  
    override func attack() {
            
      
           if !bodySprite.hasActions()
           {
               bodySprite.run(monkeySoundAction)
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
    
    
    
}// class MonkeyEntClass
