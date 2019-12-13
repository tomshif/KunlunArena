//
//  GameClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class GameClass
{
    var scene:SKScene?
    var player:PlayerClass?
    
    
    init()
    {
        
    }
    
    init(theScene:SKScene)
    {
        scene=theScene
    } // init(theScene)
    
} // class GameClass
