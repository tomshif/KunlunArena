//
//  SwordsOfLightningTalentClass.swift
//  KunlunArena
//
//  Created by 5 - Game Design on 1/23/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class SwordsOfLightningTalentClass:PlayerTalentClass
{
    var timeSinceLastUse: CGFloat=0
    
    override init(theGame:GameClass)
        
    {
        super.init(theGame: theGame)
        name="Swords of Lighting"
        description="increases attack speed by 100% for 5 seconds"
        isAction=false
        game=theGame
        COOLDOWN=15
        lengthActive=5
    }//init game
    
    override func removeTalent()
    {
        isActive=false
        game!.player!.playerTalents[0].COOLDOWN=0.25
        
    }
    
    override func updateTalent()
    {
        
    }
    
    override func doTalent()
    {
        game!.player!.playerTalents[0].COOLDOWN=0
        lastUse=NSDate()
        isActive=true
        
    }
    
}
