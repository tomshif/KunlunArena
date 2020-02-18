//
//  EnemyFireClass.swift
//  KunlunArena
//
//  Created by 8 - Game Design on 2/11/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyFireClass:EnemySkillClass
{
    var oldMovementSpeed:CGFloat=0
    
    override init(theGame: GameClass, ent: EntityClass)
    {
        super.init(theGame: theGame, ent: ent)
        
        manaCost=5
        COOLDOWN=10
        lengthActive=10
        tier=2
    } // init
    
    override func doSkill()
    {
        super.doSkill()
        oldMovementSpeed=entity!.moveSpeed
        entity!.moveSpeed=0
        
        lastUse=NSDate()
        isActive=true
        

        let fireNode=SKEmitterNode(fileNamed: "FireBreathTalentEmitter.sks")
        fireNode!.position=entity!.bodySprite.position
        fireNode!.zPosition=entity!.bodySprite.zPosition-0.00001
        fireNode!.zRotation=entity!.bodySprite.zRotation
        
        fireNode!.run(SKAction.sequence([SKAction.wait(forDuration: 1.5),SKAction.removeFromParent()]))
        fireNode!.name="fireNode"
        fireNode!.setScale(1.3)
        game!.scene!.addChild(fireNode!)
        
        print("BREATHING FIRE!!!!!")
        
    }
    
    
    override func updateSkill()
    {
        // Pick a spot in front of the enemy and see if player is there
        
        let dx=cos(entity!.bodySprite.zRotation)*10+entity!.bodySprite.position.x
        let dy=sin(entity!.bodySprite.zRotation)*10+entity!.bodySprite.position.y
        
        // get distance from player to the spot
        
        let pdx = game!.player!.playerSprite!.position.x - dx
        let pdy = game!.player!.playerSprite!.position.y - dy
        let pDist=hypot(pdy, pdx)
        
        if pDist < 100
        {
            game!.player!.takeDamage(amount: entity!.currentDamage/4)
        }
    }
    
    override func removeSkill()
    {
        entity!.moveSpeed=oldMovementSpeed
    }
    
}
