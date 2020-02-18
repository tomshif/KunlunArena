//
//  TigerClawsTalent.swift
//  KunlunArena
//
//  Created by 5 - Game Design on 2/18/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation

class TigerClawsTalentClass:PlayerTalentClass
{
   
    var oldDamage:CGFloat=0
    override init(theGame: GameClass)
    {
        super.init(theGame: theGame)
        name="TigerClaws"
        description="Double Damage for 5 seconds"
        isAction=false
        game=theGame
        COOLDOWN=10
        manaCost=10
        lengthActive=5
        iconName="tigerClawsTalentIcon"
    } // init game
    
    
    
    override func removeTalent()
    {
        game!.player!.currentDamage=oldDamage
        
       
        isActive=false
    } // removeTalent()
    
    
    override func updateTalent()
    {
        
    } // updateTalent()
    
    override func doTalent()
    {
        super.doTalent()

        
        
        
        
        
        
        oldDamage = game!.player!.currentDamage
        game!.player!.currentDamage *= 2
        lastUse=NSDate()
        isActive=true
        

    } // doTalent()
}
