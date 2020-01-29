//
//  DogEntClass.swift
//  KunlunArena
//
//  Created by 5 - Game Design on 1/29/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class DogEntClass:EntityClass
{
    var dog=SKSpriteNode(imageNamed: "dogHead00")
    var dogE=SKSpriteNode(imageNamed: "dogBody00")
    
    
    override init(theGame: GameClass, id: Int)
     {
         super.init(theGame: theGame, id: id)
         spriteNamePrefix="dog"
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
       
       
       moveSpeed=random(min: 6.5, max: 10.0)
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
         
       let entColor=NSColor(calibratedRed: random(min: 0.2, max: 0.4), green: random(min: 0.6, max: 0.8), blue: random(min: 0.7, max: 0.9), alpha: 1.0)
       
       bodySprite.color=entColor
       headSprite.color=entColor
       tailSprite.color=entColor
    


}//Init
    
        
        
        func camo()
             {
                 
                 if playerInSight==true
                 {
                     let fadeOut=SKAction.fadeOut(withDuration: 0.3)
                     let fadeIn=SKAction.fadeIn(withDuration: 0.3)
                     dogE.run(SKAction.repeatForever(fadeOut))
                     dogE.run(SKAction.repeatForever(fadeIn))
                     
                 }
    }// camo
    
        
        
    func update(_ currentTime: TimeInterval)  {
        
        camo()
        
    }
    
    
}// dogEntClass

