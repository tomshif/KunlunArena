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
     var snakeSoundAction=SKAction.playSoundFileNamed("quickBite.mp3", waitForCompletion: true)
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
    leftSprite.isHidden=true
    rightSprite.isHidden=true
    
    
    moveSpeed=random(min: 5.0, max: 5.5)
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
      
    entColor=NSColor(calibratedRed: random(min: 0.3, max: 0.4), green: random(min: 0.3, max: 0.6), blue: random(min: 0.1, max: 0.3), alpha: 1.0)
    
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor
    
    
    if entLevel >= 2
    {
        currentDamage=random(min: 3.0, max: 4.0)
    }//entLevel >= 2
    
    if entLevel == 1
    {
        currentDamage=random(min: 1.0, max: 2.0)
        
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
            bodySprite.run(snakeSoundAction)
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

    override func update(cycle: Int) {
        super.update(cycle: cycle)
        

        if health < maxHealth*0.25
        {
        
         print("snake should divide")
         if !bodySprite.name!.contains("child")
         {
             print("snake is adult, should divide")
             let childSnake=SnakeEntClass(theGame: game!, id: game!.entCount)
            game!.entCount+=1
             childSnake.bodySprite.position.x=self.bodySprite.position.x
             childSnake.bodySprite.position.y=self.bodySprite.position.y
            
            childSnake.bodySprite.name="child\(childSnake.bodySprite.name!)"
            childSnake.bodySprite.setScale(self.bodySprite.xScale)
            
             self.bodySprite.name="child\(self.bodySprite.name!)"
             
             game!.entList.append(childSnake)
             
        }// checking if its a child snake if not spawn a second snake
                
         } // if
        
    }// update func
    
    
}// class SnakeEntClass


