//
//  AngerIssuesTalentClass.swift
//  KunlunArena
//
//  Created by Michael Ramirez on 1/28/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation

import SpriteKit

class AngerIssuesTalentClass:PlayerTalentClass
{
    
    
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="GhostDodge"
        description="Increase Attack Damage by 50%."
        isAction=false
        game=theGame
        COOLDOWN=3
        lengthActive=10
        
    } // init game
    
    
    override func removeTalent()
    {
        
        game!.player!.currentDamage = game!.player!.currentDamage / 1.5
        isActive=false
    } // removeTalent()
    
    
    override func updateTalent()
    {
        
        
    } // updateTalent()
    
    override func doTalent()
    {
        print("ANGER!!!!")

        lastUse=NSDate()
        isActive=true
            

    } // doTalent()
    
} // class AngerIssuesTalentClass
