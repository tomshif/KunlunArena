//
//  TestEntClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 1/21/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class TestEntClass:EntityClass
{
    override init(theGame: GameClass, id: Int)
    {
        super.init(theGame: theGame, id: id)
        spriteNamePrefix="testEnt"
        headNum=3
        bodyNum=3
        tailNum=3

        headID=Int(random(min: 0, max: CGFloat(headNum)-0.000000001))
        bodyID=Int(random(min: 0, max: CGFloat(bodyNum)-0.000000001))
        tailID=Int(random(min: 0, max: CGFloat(tailNum)-0.000000001))
        
        
        headSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Head0\(headID)")
        bodySprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Body0\(bodyID)")
        tailSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Tail0\(tailID)")
        spriteScale=random(min: 1.5, max: 3.5)
        bodySprite.setScale(spriteScale)
        
    } // init scene/ID
} // class TestEntClass
