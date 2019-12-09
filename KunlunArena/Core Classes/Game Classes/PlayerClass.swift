//
//  PlayerClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerClass
{
    var game:GameClass?
    var playerSprite:SKSpriteNode?
    
    var health:Int=100
    
    
    init()
    {
        
    }
    init(theGame:GameClass)
    {
        game=theGame
    }
    
    
    
}
