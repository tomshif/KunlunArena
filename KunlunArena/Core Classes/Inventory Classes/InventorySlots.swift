//
//  InventorySlots.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/10/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This file allows us easily reference a specific inventory type.
//
// For example, if we are instancing a new BaseInventoryClass, we can set the invType by:
//
// thisWeapon.invType=INVENTORYSLOTS.melee
//
// This allows us to easily set the type without having to memorize (or lookup) the Int value of each inventory slot

import Foundation

struct INVENTORYSLOTS
{
    static let weapon:Int=0
    static let body:Int=2
    static let head:Int=4
    static let boots:Int=6
} // struct INVENTORYSLOTS
