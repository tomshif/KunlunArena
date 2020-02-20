//
//  CherryBombTalentClass.swift
//  KunlunArena
//
//  Created by Michael Ramirez on 1/31/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class CherryBombTalentClass:PlayerTalentClass
{
    var bombSoundAction=SKAction.playSoundFileNamed("grenadeShort.mp3", waitForCompletion: true)
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="Cherry Bomb"
        description="little cherry BIG EXPLOSION."
        isAction=false
        game=theGame
        COOLDOWN=10
        lengthActive=1.5
        manaCost=20
        iconName="cherryBombTalentIcon"
    } // init game
    
    
    override func doTalent()
    {
        super.doTalent()
        
        lastUse=NSDate()
        isActive=true
        
        
        game!.player!.mana -= manaCost
        
        // determine dx/dy to center of hit area
        let dx=cos(game!.player!.playerSprite!.zRotation)*200+game!.player!.playerSprite!.position.x
        let dy=sin(game!.player!.playerSprite!.zRotation)*200+game!.player!.playerSprite!.position.y
        
        // check for all enemies within 100 pixels of this spot
        var dist:CGFloat=0
        for ent in game!.entList
        {
            // compute distance of ent from center of area
            
            let entdx=dx-ent.bodySprite.position.x
            let entdy=dy-ent.bodySprite.position.y
            let dist=hypot(entdy,entdx)
            
            if dist < 100
            {
                ent.takeDamage(amount: game!.player!.equippedWeapon!.iLevelMod * game!.player!.equippedWeapon!.modLevel*5)
                
            } // if in range do damage
        } // for each ent
        
        let cherryNode=SKEmitterNode(fileNamed: "CherryBombEffect")
        cherryNode!.position=CGPoint(x: dx, y: dy)
        cherryNode!.zPosition=game!.player!.playerSprite!.zPosition-0.00001
        cherryNode!.zRotation=game!.player!.playerSprite!.zRotation
        
        cherryNode!.run(SKAction.sequence([SKAction.wait(forDuration: 2),SKAction.removeFromParent()]))
        game!.scene!.addChild(cherryNode!)
        
        game!.player!.playerSprite?.run(bombSoundAction)
        
    } // doTalent()
    override func updateTalent()
    {
        
         
        
    } // update talent
    override func removeTalent()
    {
        
        isActive=false
    } // removeTalent()
    
} // CherryBombTalentClass
