//
//  WindStormTalentClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 2/6/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation

import SpriteKit

class WindStormTalentClass:PlayerTalentClass
{
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="wind storm"
        description="sends a wind that swirls as strong as the winds of a hurricane"
        isAction=false
        game=theGame
        COOLDOWN=5
        lengthActive=10
        iconName="windstormTalentIcon"
    } // init game
    
    override func doTalent()
        {
            game!.player!.moveSpeed=0
            
            lastUse=NSDate()
            isActive=true
            
            print("wind")
            let fireNode=SKEmitterNode(fileNamed: "FireBreathTalentEmitter.sks")
            fireNode!.position=game!.player!.playerSprite!.position
            fireNode!.zPosition=game!.player!.playerSprite!.zPosition-0.00001
            fireNode!.zRotation=game!.player!.playerSprite!.zRotation
            
            fireNode!.run(SKAction.sequence([SKAction.wait(forDuration: 1.5),SKAction.removeFromParent()]))
            fireNode!.name="fireNode"
            fireNode!.setScale(1.3)
            game!.scene!.addChild(fireNode!)
            
     
            
        } // doTalent()
        override func updateTalent()
        {
            game!.player!.mana -= manaCost/2/4
            
            // rotate effect to player
            let node=game!.scene!.childNode(withName: "windNode")
            node?.zRotation=game!.player!.playerSprite!.zRotation
            
            // check for enemies hit
             
             // determine dx/dy to center of hit area
             let dx=cos(game!.player!.playerSprite!.zRotation)*100+game!.player!.playerSprite!.position.x
             let dy=sin(game!.player!.playerSprite!.zRotation)*100+game!.player!.playerSprite!.position.y
             
             // check for all enemies within 100 pixels of this spot
             for ent in game!.entList
             {
                 // compute distance of ent from center of area
                 let entdx=dx-ent.bodySprite.position.x
                 let entdy=dy-ent.bodySprite.position.y
                 let dist=hypot(entdy,entdx)

                 if dist < 200
                 {
                     ent.takeDamage(amount: game!.player!.equippedWeapon!.iLevelMod * game!.player!.equippedWeapon!.modLevel*3/4/2)
                     
                 } // if in range do damage
             } // for each ent
             
            
        } // update talent
        override func removeTalent()
        {
            
            isActive=false
        } // removeTalent()
        
    } // WindStormTalentClass
