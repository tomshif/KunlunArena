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
    override init(theGame: GameClass, id: Int)
{
    super.init(theGame: theGame, id: id)
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
    
    moveSpeed=random(min: 5.5, max: 10.5)
    attackRange=random(min: 25, max: 200)
    VISIONDIST=random(min: 500, max: 500)
    if attackRange > 45
    {
        pursueRange=attackRange*2
    }
    else
    {
        pursueRange=attackRange
    }
      
    let entColor=NSColor(calibratedRed: random(min: 0.5, max: 0.7), green: random(min: 0.6, max: 0.9), blue: random(min: 0, max: 0.4), alpha: 1.0)
    bodySprite.color=entColor
    headSprite.color=entColor
    tailSprite.color=entColor
    
    func takeDamage(amount: CGFloat)
    {
        health -= amount*(1-damageReduction)
        print("\(amount) reduced to \(amount*(1-damageReduction))")
        
        // create a flash effect to indicate it got hit
        bodySprite.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.5, duration: 0.1), SKAction.fadeAlpha(to: 1.0, duration: 0.1)]))
        game!.floatText!.damageLabel(amount: amount*(1-damageReduction), ent: self)
        // create blood splatter
        for _ in 1...5
        {
            let tempBlood=SKSpriteNode(imageNamed: "bloodSplatter")
            tempBlood.position=bodySprite.position
            tempBlood.zPosition=15
            tempBlood.zRotation=random(min: 0, max: CGFloat.pi*2)
            tempBlood.run(SKAction.sequence([SKAction.move(by: CGVector(dx: random(min: -100, max: 100), dy: random(min: -100, max: 100)), duration: 0.4), SKAction.wait(forDuration: 2.0), SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
            tempBlood.name="bloodSplatter"
            game!.scene!.addChild(tempBlood)
        } // for
        
    } // takeDamage()
    
    
    
    
   
    } // init scene/ID}
}// class TestEntClass
