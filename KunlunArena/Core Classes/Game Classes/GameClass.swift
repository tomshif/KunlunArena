//
//  GameClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This class is the holder class for all key elements of the game.
//
// This class should not be sub classed and virtually everything in the class will be publicly exposed so that the main (GameScene) code can directly access it.
//
// It holds references to the scene, player, entity list, etc., in order for instances of those classes to be able to easily see the exposure of each other.

import Foundation
import SpriteKit

class GameClass
{
    var scene:SKScene?
    var player:PlayerClass?
    var floatText:FloatingTextClass?
    var entList=[EntityClass]() // needs to move to GameClass
    var suffixList=[SuffixClass]()
    var prefixList=[PrefixClass]()
    var baseTypesList=[BaseInvTypesClass]()
    
    
    init()
    {
        
    }
    
    init(theScene:SKScene)
    {
        scene=theScene
        floatText=FloatingTextClass(theScene: scene!)
        
    } // init(theScene)
    
} // class GameClass
