//
//  JadeStormTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 2/18/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class JadeStormTalentClass:PlayerTalentClass
{
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="Jade Storm"
        description="Turn nearby enemies to jade...the next damaging attack to them will shatter them."
        isAction=false
        game=theGame
        COOLDOWN=1.0
        lengthActive=5.0
        iconName="ghostDodgeTalentIcon4"
    } // init game
    
    
    
    override func removeTalent()
    {
        // This talent will be called when the talent expires.
        // Note that this will always be called from the GameScene and should not be called internally.

        for ents in game!.entList
        {
            if ents.statusEffect == SPECIALSTATUS.jade
            {
                ents.statusEffect=SPECIALSTATUS.none
                ents.bodySprite.color=ents.entColor
                ents.headSprite.color=ents.entColor
                ents.tailSprite.color=ents.entColor
                ents.rightSprite.color=ents.entColor
                ents.leftSprite.color=ents.entColor

            }
        } // for each entity
    } // removeTalent()
    
    
    override func updateTalent()
    {
        
    } // updateTalent()
    
    override func doTalent()
    {
        super.doTalent()

        let jadeEffect = SKEmitterNode(fileNamed: "JadeStormEmitter.sks")
        jadeEffect!.name="ghostTalentEffect"
        jadeEffect!.zPosition=150
        jadeEffect!.position=game!.player!.playerSprite!.position
        game!.scene!.addChild(jadeEffect!)
        jadeEffect!.run(SKAction.repeatForever( SKAction.rotate(byAngle: CGFloat.pi*4, duration: 1.0)))
        jadeEffect!.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.fadeOut(withDuration: 0.3),SKAction.removeFromParent()]))
        
        


        // find all nearby enemies and jade-ize them
        
        for ents in game!.entList
        {
            if ents.playerDist < 200
            {
                ents.statusEffect=SPECIALSTATUS.jade
                
                ents.bodySprite.color=NSColor.green
                ents.headSprite.color=NSColor.green
                ents.tailSprite.color=NSColor.green
                ents.rightSprite.color=NSColor.green
                ents.leftSprite.color=NSColor.green

                
                
                
            }
        }
        
        lastUse=NSDate()
        isActive=true
        

    } // doTalent()
    
} // class GhostDodgeTalentClass
