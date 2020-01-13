//
//  PlayerTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/10/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerTalentClass
{
    var game:GameClass?
    var name:String="Talent"
    var isAction:Bool=false
    var tier:Int=0
    var lastUse=NSDate()
    
    var COOLDOWN:Double=1.5
    
    
    
    
    init(theGame: GameClass)
    {
        game=theGame
        
    } // init game
    
    public func doTalent()
    {
        
    } // doTalent()
    
    
} // PlayerTalentClass
