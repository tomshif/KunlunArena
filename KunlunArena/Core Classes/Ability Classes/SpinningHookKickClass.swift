//
//  SpinningHookKickClass.swift
//  KunlunArena
//
//  Created by 5 - Game Design on 2/20/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class SpinningHookKick:PlayerTalentClass
{
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="Spinning Hook Kick"
        description="Spin and kick doing massive damage."
        isAction=false
        game=theGame
        COOLDOWN=1
        lengthActive=2.0
        manaCost=5.0
        iconName="ghostDodgeTalentIcon4"
    } // init game
    
    override func removeTalent()
       {
           // This talent will be called when the talent expires.
           // Note that this will always be called from the GameScene and should not be called internally.
/*
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
          
*/     //} // for each entity
       } // removeTalent()
    
    override func updateTalent()
    {
        
    } // updateTalent()
    
    override func doTalent()
    {
        super.doTalent()

        let spinningKick = SKEmitterNode(fileNamed: "JadeStormEmitter.sks")
        spinningKick!.name="ghostTalentEffect"
        spinningKick!.zPosition=150
        spinningKick!.position=game!.player!.playerSprite!.position
        game!.scene!.addChild(spinningKick!)
        //spinningKick!.run(SKAction.repeatForever( SKAction.rotate(byAngle: CGFloat.pi*4, duration: 2.0)))
        //spinningKick!.run(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.fadeOut(withDuration: 0.3),SKAction.removeFromParent()]))
        
        spinningKick!.run(SKAction.rotate(byAngle: CGFloat.pi*2, duration: 2.0))
        
        for ent in game!.entList
        {
            let dx=ent.bodySprite.position.x - game!.player!.playerSprite!.position.x
            let dy=ent.bodySprite.position.y - game!.player!.playerSprite!.position.y
            
            let dist=hypot(dy, dx)
            
            if dist < 200
            {
                // damage
                ent.takeDamage(amount: CGFloat(game!.player!.equippedWeapon!.iLevel)*game!.player!.equippedWeapon!.modLevel)
            }
        
            
            
        lastUse=NSDate()
        isActive=true
        

    } // for
    }//do Talent()
}//class spinning hook kick

