//
//  BaseInvTypesClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 1/27/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class BaseInvTypesClass
{
    var name:String=""
    var modifier:CGFloat=0
    var talentType:Int=0
    
    init(n: String, m: CGFloat, t: Int)
    {
        name=n
        modifier=m
        talentType=t
    } // init
}// class BaseInvTypesClass

