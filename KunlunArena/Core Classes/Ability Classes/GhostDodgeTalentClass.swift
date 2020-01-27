//
//  GhostDodgeTalentClass.swift
//  KunlunArena
//
//  Created by Michael Ramirez on 1/24/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation

import SpriteKit

class GhostTalentClass:PlayerTalentClass
{
    var oldArmor:CGFloat=0
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="GhostDodge"
        description="Player becomes impervious to incoming damage"
        isAction=false
        game=theGame
        COOLDOWN=7.5
        lengthActive=5
        
        oldArmor = game!.player!.damageReduction
    } // init game
    
    
    override func removeTalent()
    {
        // This talent will be called when the talent expires.
        // Note that this will always be called from the GameScene and should not be called internally.

        game!.player!.damageReduction = oldArmor //restores armor stats
        isActive=false
    } // removeTalent()
    
    
    override func updateTalent()
    {
        // This method is called each frame while the method is active
        // If the talent is a one shot thing, this method won't need to do anything.
        // Note that this will always be called from the GameScene and should not be called internally.
        
    } // updateTalent()
    
    override func doTalent()
    {
        // This method will be called when the talent is first begun.
        // Note that this will always be called from the GameScene and should not be called internally.
        
        game!.player!.damageReduction = 1 //player becomes immune to incoming attacks
        lastUse=NSDate()
        isActive=true
            

    } // doTalent()
    
} // class GhostDodgeTalentClass
