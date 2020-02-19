//
//  SpecialStatus.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/10/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This is a quick reference for various status effects that can affect both player and entities.
// They can be accessed as:
//
// player.status=SPECIALSTATUS.jade
//

import Foundation

struct SPECIALSTATUS
{
    static let none:Int=0
    static let fire:Int=2
    static let jade:Int=4
    static let frozen:Int=6
    static let poison:Int=8
}
