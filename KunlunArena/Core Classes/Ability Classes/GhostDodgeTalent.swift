//
//  GhostDodgeTalent.swift
//  KunlunArena
//
//  Created by Michael Ramirez on 1/27/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation

import SpriteKit

class GhostDodgeTalentClass:PlayerTalentClass
{
    var oldArmor:CGFloat=0
    var ghostEffect = SKEmitterNode(fileNamed: "GhostDodgeEmitter")
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="GhostDodge"
        description="Player is Invanerable for 5 seconds."
        isAction=false
        game=theGame
        COOLDOWN=7.5
        lengthActive=5
        iconName="ghostDodgeTalentIcon"
    } // init game
    
    
    
    override func removeTalent()
    {
        // This talent will be called when the talent expires.
        // Note that this will always be called from the GameScene and should not be called internally.
        
        game!.player!.playerTalents[0].COOLDOWN=7.5
        game!.player!.damageReduction = oldArmor
        isActive=false
    } // removeTalent()
    
    
    override func updateTalent()
    {
        // This method is called each frame while the method is active
        // If the talent is a one shot thing, this method won't need to do anything.
        // Note that this will always be called from the GameScene and should not be called internally.
        while isActive
        {
            ghostEffect!.position = game!.player!.playerSprite!.position
        }
    } // updateTalent()
    
    override func doTalent()
    {
        // This method will be called when the talent is first begun.
        // Note that this will always be called from the GameScene and should not be called internally.
        
        game!.player!.playerTalents[0].COOLDOWN=0
        oldArmor = game!.player!.damageReduction
        game!.player!.damageReduction = 1
        lastUse=NSDate()
        isActive=true
        game!.scene!.addChild(ghostEffect!)

    } // doTalent()
    
} // class GhostDodgeTalentClass

