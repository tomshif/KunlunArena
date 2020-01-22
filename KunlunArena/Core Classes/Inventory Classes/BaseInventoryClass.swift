//
//  BaseInventoryClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/4/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
//
// This class will be the base class for the different inventory types. It won't be sub classed, but instanced out to represent different weapons.

import Foundation
import SpriteKit

class BaseInventoryClass
{
    var name:String=""
    var iLevel:Int=0
    var invType:Int=0
    
    var prefixNum:Int=0
    var suffixNum:Int=0
    var invSlot:Int=0
    
} // class BaseInventoryClass

