//
//  FloatingTextClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 1/17/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//
// This class is to allow us to easily create floating text as visual indicators for things such as damage or healing done, status effects being applied, etc).
// Essentially it will create a small SKLabel of a certain color that drifts up from the target location and fades out.
//



import Foundation
import SpriteKit


class FloatingTextClass
{
    
    var scene:SKScene?
    var zPos:CGFloat=50
    
    init(theScene: SKScene)
    {
        scene=theScene
    }
    
    public func damageLabel(amount: CGFloat, ent: EntityClass)
    {
        let tempLabel=SKLabelNode(text: String(format:"-%2.0f", amount))

        tempLabel.zPosition=zPos
        tempLabel.position=ent.bodySprite.position
        tempLabel.name="damageLabel"
        tempLabel.fontName="Chalkboard"
        var horzMov=random(min: 25, max: 75)
        let chance=random(min: 0, max: 1.0)
        if chance > 0.5
        {
            horzMov *= -1
        }
        tempLabel.run(SKAction.sequence([SKAction.move(by: CGVector(dx: horzMov, dy: 100), duration: 1),  SKAction.removeFromParent()]))
        tempLabel.run(SKAction.sequence([SKAction.wait(forDuration: 0.8),SKAction.fadeOut(withDuration: 0.2)]))
        tempLabel.fontColor=NSColor.red
        
        scene!.addChild(tempLabel)
        
        
        
        
    } // damageLabel
    
    // Overload for player
    public func damageLabel(amount: CGFloat, player: PlayerClass)
    {
        let tempLabel=SKLabelNode(text: String(format:"-%2.0f", amount))

        tempLabel.zPosition=zPos
        tempLabel.position=player.playerSprite!.position
        tempLabel.name="damageLabel"
        tempLabel.fontName="Chalkboard"
        tempLabel.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: 100), duration: 1),  SKAction.removeFromParent()]))
        tempLabel.run(SKAction.sequence([SKAction.wait(forDuration: 0.8),SKAction.fadeOut(withDuration: 0.2)]))
        tempLabel.fontColor=NSColor.red
        
        scene!.addChild(tempLabel)
        
        
        
        
    } // damageLabel
    
    public func healLabel(amount: CGFloat, ent: EntityClass)
    {
        let tempLabel=SKLabelNode(text: String(format:"-%2.0f", amount))

        tempLabel.zPosition=zPos
        tempLabel.position=ent.bodySprite.position
        tempLabel.name="healLabel"
        tempLabel.fontName="Chalkboard"
        tempLabel.run(SKAction.sequence([SKAction.move(by: CGVector(dx: 10, dy: 100), duration: 1),  SKAction.removeFromParent()]))
        tempLabel.run(SKAction.sequence([SKAction.wait(forDuration: 0.8),SKAction.fadeOut(withDuration: 0.2)]))
        tempLabel.fontColor=NSColor.green
        
        scene!.addChild(tempLabel)
        
        
    } // healLabel
    
    // Overload for player
    public func healLabel(amount: CGFloat, player: PlayerClass)
    {
        let tempLabel=SKLabelNode(text: String(format:"+%2.0f", amount))

        tempLabel.zPosition=zPos
        tempLabel.position=player.playerSprite!.position
        tempLabel.name="healLabel"
        tempLabel.fontName="Chalkboard"
        let driftSide=Int(random(min: 0, max: 2))
        var drift=random(min: 25, max: 50)

        
        if driftSide > 0
        {
            drift = -drift
        }

        tempLabel.run(SKAction.sequence([SKAction.move(by: CGVector(dx: drift, dy: 100), duration: 1),  SKAction.removeFromParent()]))
        tempLabel.run(SKAction.sequence([SKAction.wait(forDuration: 0.8),SKAction.fadeOut(withDuration: 0.2)]))
        tempLabel.fontColor=NSColor.green
        
        scene!.addChild(tempLabel)
        
        
    } // healLabel
    
} // FloatingTextClass
