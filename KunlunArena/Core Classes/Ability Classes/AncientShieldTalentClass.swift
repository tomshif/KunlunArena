//
//  AncientShieldTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 2/18/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit


class AncientShieldTalentClass:PlayerTalentClass
{


       var fireSundAction=SKAction.playSoundFileNamed("flameThrower", waitForCompletion: true)
       
    var oldArmor:CGFloat=0.0
    
       override init(theGame: GameClass)
       {
           // This is the only initializer that will ever be used. We will always pass the class when initializing talents
           super.init(theGame: theGame)
           name="Ancient Shield"
           description="Summons an ancestral shield to protect you from all attacks for 5 seconds."
           isAction=false
           game=theGame
           COOLDOWN=1
        lengthActive=5.0
           manaCost=2
           iconName="fireBreathTalentIcon"
       } // init game
       
       
       override func doTalent()
       {
           super.doTalent()
        
           oldArmor = game!.player!.damageReduction
           game!.player!.damageReduction = 1
           lastUse=NSDate()
           isActive=true

            let shield=SKSpriteNode(imageNamed: "shieldEffect")
        game!.player!.playerSprite!.addChild(shield)
        shield.zPosition=10
        shield.setScale(4.0)
        shield.run(SKAction.repeatForever( SKAction.sequence([SKAction.fadeAlpha(to: 0.5, duration: 0.25),SKAction.fadeAlpha(to: 1.0, duration: 0.25)])))
        shield.run(SKAction.repeatForever( SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi*2, duration: 0.35),SKAction.rotate(byAngle: -CGFloat.pi*2, duration: 0.35)])))
        shield.name="ancientShieldImage"
           
       } // doTalent()
       override func updateTalent()
       {

           
       } // update talent
       override func removeTalent()
       {
        game!.player!.damageReduction=oldArmor
        for node in game!.player!.playerSprite!.children
        {
            if node.name != nil
            {
                if node.name!.contains("ancientShieldImage")
                {
                    node.removeFromParent()
                }
            } // if not nil
        } // for each child node on player
           isActive=false
       } // removeTalent()
    
} // class HowlingWindTalentClass

