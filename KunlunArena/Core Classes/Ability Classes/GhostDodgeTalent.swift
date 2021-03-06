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
        iconName="ghostDodgeTalentIcon4"
    } // init game
    
    
    
    override func removeTalent()
    {
        // This talent will be called when the talent expires.
        // Note that this will always be called from the GameScene and should not be called internally.
        
        
        game!.player!.damageReduction = oldArmor
        isActive=false
    } // removeTalent()
    
    
    override func updateTalent()
    {
        
    } // updateTalent()
    
    override func doTalent()
    {
        super.doTalent()

        let ghostEffect = SKEmitterNode(fileNamed: "GhostDodgeEmitter.sks")
        ghostEffect!.name="ghostTalentEffect"
        game!.player!.playerSprite!.addChild(ghostEffect!)
        
        
        
        ghostEffect!.zPosition = 200
        ghostEffect!.alpha=1
        ghostEffect!.run(SKAction.sequence([SKAction.wait(forDuration: 4),SKAction.fadeOut(withDuration: 1.0), SKAction.removeFromParent()]))
        
        oldArmor = game!.player!.damageReduction
        game!.player!.damageReduction = 1
        lastUse=NSDate()
        isActive=true
        

    } // doTalent()
    
} // class GhostDodgeTalentClass

