//
//  States.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/4/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This is used for our current game state in the main (GameScene) code.
//
// We can set the gameState variable by:
//
// gameState=STATES.FIGHT
//
// This allows us to easily access the state instead of memorizing (or looking up) the Int values for each state.

import Foundation

struct STATES
{
    static let FIGHT:Int=0
    static let SPAWNWALL:Int=2
    static let SPAWNVERTWALL:Int=3
    
    static let SPAWNENT:Int=4
    static let PAUSE:Int=6
} // struct STATES
