//
//  BloomingFlowerTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 2/5/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class BloomingFlowerTalentClass:PlayerTalentClass
{


   
   override init(theGame: GameClass)
   {
       // This is the only initializer that will ever be used. We will always pass the class when initializing talents
       super.init(theGame: theGame)
       name="Blooming Flower"
       description="Flowers bloom in the area around the player, healing over time."
       isAction=false
       game=theGame
       COOLDOWN=15
       lengthActive=5
       manaCost=15
       iconName="bloomingFlowerTalentIcon"
   } // init game
   
   
   override func doTalent()
   {
       super.doTalent()
        lastUse=NSDate()
        isActive=true
       
   } // doTalent()
    
   override func updateTalent()
   {
    // Heal the player a little bit, based on their weapon level and their wisdom
    let totalHealAmount = game!.player!.equippedWeapon!.modLevel*CGFloat(game!.player!.equippedWeapon!.iLevel)*game!.player!.wisdom/20
    
    game!.player!.receiveHealing(amount: totalHealAmount/4/CGFloat(lengthActive))
    
    // create flowers around the player
    // updated every 15 frames, so we need to draw a few
    for _ in 0...3
    {
        let flower=SKSpriteNode(imageNamed: "flowerBloom")
        flower.zPosition=3
        let xOffset = random(min: -128, max: 128)
        let yOffset = random(min: -128, max: 128)
        flower.position.x=game!.player!.playerSprite!.position.x+xOffset
        flower.position.y=game!.player!.playerSprite!.position.y+yOffset
        
        flower.colorBlendFactor=1.0
        let colorChoice=Int(random(min: 0, max: 4.9999))
        var color=NSColor.white
        switch colorChoice
        {
        case 0:
            color=NSColor.red
        case 1:
            color=NSColor.blue
        case 2:
            color=NSColor.yellow
        case 3:
            color=NSColor.purple
        default:
            break
        }
        flower.color=color
        flower.alpha=0.0
        flower.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.65),SKAction.wait(forDuration: 2.0), SKAction.fadeOut(withDuration: 1.0),SKAction.removeFromParent()]))
        game!.scene!.addChild(flower)
    } // for each flower generated
       
   } // update talent
    
    
    
   override func removeTalent()
   {
       
       isActive=false
   } // removeTalent()


} // BloomingFlowerTalentClass

