//
//  JadeStormTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 2/18/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class JadeStormTalentClass:PlayerTalentClass
{
    var oldArmor:CGFloat=0
    
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="Jade Storm"
        description="Turn nearby enemies to jade...the next damaging attack to them will shatter them."
        isAction=false
        game=theGame
        COOLDOWN=7.5
        lengthActive=0
        iconName="ghostDodgeTalentIcon4"
    } // init game
    
    
    
    override func removeTalent()
    {
        // This talent will be called when the talent expires.
        // Note that this will always be called from the GameScene and should not be called internally.

    } // removeTalent()
    
    
    override func updateTalent()
    {
        
    } // updateTalent()
    
    override func doTalent()
    {
        super.doTalent()

        let ghostEffect = SKEmitterNode(fileNamed: "GhostDodgeEmitter.sks")
        ghostEffect!.name="ghostTalentEffect"
        game!.scene!.addChild(ghostEffect!)
        
        
        
        ghostEffect!.zPosition = 200
        ghostEffect!.alpha=1
        ghostEffect!.run(SKAction.sequence([SKAction.wait(forDuration: 4),SKAction.fadeOut(withDuration: 1.0), SKAction.removeFromParent()]))

        lastUse=NSDate()
        isActive=true
        

    } // doTalent()
    
} // class GhostDodgeTalentClass
