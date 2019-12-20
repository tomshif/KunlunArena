//
//  BodyBitMasks.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/19/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import Foundation

struct BODYBITMASKS
{
    static let NOTHING:         UInt32=0b0000000000000001
    static let PLAYER:          UInt32=0b0000000000000010
    static let ENEMY:           UInt32=0b0000000000000100
    static let BOSS:            UInt32=0b0000000000001000
    static let WALL:            UInt32=0b0000000000010000
    static let VIRUS:           UInt32=0b0000000000100000
    static let LIGHTNING:       UInt32=0b0000000001000000
    static let POISONCLOUD:     UInt32=0b0000000010000000

    static let EVERYTHING: UInt32=UInt32.max
} // PHYSICSTYPES
