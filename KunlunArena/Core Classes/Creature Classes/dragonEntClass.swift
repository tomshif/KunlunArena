//
//  dragonEntClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 1/23/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class dragonEntClass:EntityClass
{
    override init(theScene: SKScene, id: Int)
{
    super.init(theScene: theScene, id: id)
    spriteNamePrefix="dragon"
    headNum=1
    bodyNum=1
    tailNum=1
    
    headID=Int(random(min: 0, max: CGFloat(headNum)-0.000000001))
    bodyID=Int(random(min: 0, max: CGFloat(bodyNum)-0.000000001))
    tailID=Int(random(min: 0, max: CGFloat(tailNum)-0.000000001))
    
    headSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Head0\(headID)")
    bodySprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Body0\(bodyID)")
    tailSprite.texture=SKTexture(imageNamed: "\(spriteNamePrefix)Tail0\(tailID)")
    spriteScale=random(min: 1.5, max: 3.5)
    bodySprite.setScale(spriteScale)
    
    moveSpeed=random(min: 6.2, max: 10.7)
    attackRange=random(min: 17, max: 200)
    VISIONDIST=random(min: 500, max: 500)
    if attackRange > 45
    {
        pursueRange=attackRange*2
    }
    else
    {
        pursueRange=attackRange
    }
      
    let entColor=NSColor(calibratedRed: random(min: 0.9, max: 1.0), green: random(min: 0.8, max: 0.9), blue: random(min: 0.8, max: 0.9), alpha: 1.0)
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor
    
    
    
    
   
    } // init scene/ID}
}// class TestEntClass
