//
//  SuffixEffects.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 1/27/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//
// These are used in the creation of random inventory items.
//
// Prime numbers are used for each of effect so that we know that the product of these numbers will only be evenly divisible by those prime numbers.
// For example, if we Wisdom and Health on a piece of equipment, we multiple the 3 and the 5 to get 15. If we divide (modulus) by 3 and 5, we get a remainder of 0, but if we divide (mod) by any of the other prime numbers, we get a non-zero remainder. So we can easily figure out which effects are on the equipment.
//

import Foundation
import SpriteKit

struct suffixEffects
{
    static let STRENGTH:Int=2
    static let QUICKNESS:Int=3
    static let WISDOM:Int=5
    static let HEALTH:Int=7
    static let MANA:Int=11
    static let HEALTHREGEN:Int=13
    static let MANAREGEN:Int=17
    static let MOVESPEED:Int=19
    static let CRITICAL:Int=23
    static let ARMOR:Int=29
    static let ATTACKSPEED:Int=31
    
}
