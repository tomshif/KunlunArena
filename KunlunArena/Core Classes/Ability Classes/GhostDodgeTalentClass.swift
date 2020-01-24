//
//  GhostDodgeTalentClass.swift
//  KunlunArena
//
//  Created by Michael Ramirez on 1/23/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation

import SpriteKit


class GhostDodgeTalentClass:PlayerTalentClass
{
    
    var oldArmor:CGFloat = 0
    var oldStrength:CGFloat = 0
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        
        
        super.init(theGame: theGame)
        name="GhostDodge"
        description="Player is impervious to incoming attacks for 5 seconds but cannot attack enimies while in this state."
        isAction=false
        game=theGame //ask about this
        COOLDOWN=7.5
        lengthActive=5
        
        oldArmor=game!.player!.damageReduction
        oldStrength=game!.player!.strength
        
    } // init game
    
    
    override func removeTalent()
    {
        // This talent will be called when the talent expires.
        // Note that this will always be called from the GameScene and should not be called internally.

        game!.player!.strength = oldStrength //restores strength to normal
        game!.player!.damageReduction = oldArmor //restores armor to normal
        isActive=false
    } // removeTalent()
    
    
    override func updateTalent()
    {
        
    } // updateTalent()
    
    override func doTalent()
    {
        // This method will be called when the talent is first begun.
        // Note that this will always be called from the GameScene and should not be called internally.
        
        game!.player!.strength = 0 //player can not attack
        game!.player!.damageReduction = 1 // Immune to incoming attacks
        lastUse=NSDate()
        isActive=true
            

    } // doTalent()
    
} // class GhostDodgeTalentClass



//Possible Bugs: 1.(If a player equips a new peice of armor during GhostDodge it could restore the  stats of the old armor.)
