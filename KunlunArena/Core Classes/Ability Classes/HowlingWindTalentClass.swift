//
//  HowlingWindTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 2/15/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class HowlingWindTalentClass:PlayerTalentClass
{


       var fireSundAction=SKAction.playSoundFileNamed("flameThrower", waitForCompletion: true)
       
       override init(theGame: GameClass)
       {
           // This is the only initializer that will ever be used. We will always pass the class when initializing talents
           super.init(theGame: theGame)
           name="Howling Wind"
           description="Knocks back enemies and causes 100% weapon damage."
           isAction=false
           game=theGame
           COOLDOWN=1
        lengthActive=0.5
           manaCost=2
           iconName="fireBreathTalentIcon"
       } // init game
       
       
       override func doTalent()
       {
           super.doTalent()
           

           
           lastUse=NSDate()
           isActive=true
           

           let windNode=SKEmitterNode(fileNamed: "HowlingWindEmitter.sks")
           windNode!.position=game!.player!.playerSprite!.position
           windNode!.zPosition=game!.player!.playerSprite!.zPosition-0.00001
           windNode!.zRotation=game!.player!.playerSprite!.zRotation
           
        windNode!.run(SKAction.sequence([SKAction.wait(forDuration: 1.0),SKAction.removeFromParent()]))
           windNode!.name="windNode"
           windNode!.setScale(1.3)
           game!.scene!.addChild(windNode!)
           
           game!.player!.playerSprite?.run(fireSundAction)
    
        // find all entities around and damage them / knock them back
        for ent in game!.entList
        {
            let dx=ent.bodySprite.position.x - game!.player!.playerSprite!.position.x
            let dy=ent.bodySprite.position.y - game!.player!.playerSprite!.position.y
            
            let dist=hypot(dy, dx)
            
            if dist < 200
            {
                // damage
                ent.takeDamage(amount: CGFloat(game!.player!.equippedWeapon!.iLevel)*game!.player!.equippedWeapon!.modLevel)
                
                
                // knockback
                let angle=ent.getAngleToPlayer()
                let adx=cos(angle)*100
                let ady=sin(angle)*100
                ent.bodySprite.physicsBody!.applyImpulse(CGVector(dx: adx, dy: ady))
                
                ent.bodySprite.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run {
                    ent.bodySprite.physicsBody!.velocity=CGVector(dx: 0, dy: 0)
                    }, SKAction.run {
                        ent.bodySprite.physicsBody!.angularVelocity=0
                    }]))
                
            }
        }
           
       } // doTalent()
       override func updateTalent()
       {

           
       } // update talent
       override func removeTalent()
       {
           
           isActive=false
       } // removeTalent()
    
} // class HowlingWindTalentClass
