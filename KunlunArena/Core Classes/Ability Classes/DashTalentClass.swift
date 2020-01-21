//
//  DashTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/24/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class DashTalentClass:PlayerTalentClass
{
    var dashDistance:CGFloat=400
    var dashSpeed:CGFloat=1.5
    var lastStreak=NSDate()
    var streak=SKSpriteNode(imageNamed: "dashStreak")
    
    override init(theGame: GameClass)
    {
        super.init(theGame: theGame)
        name="Dash"
        isAction=true
        game=theGame
        COOLDOWN=5
        lengthActive=2
    } // init game
    
    
    override func removeTalent()
    {
        game!.player!.moveSpeed /= dashSpeed
        isActive=false
    } // removeTalent()
    
    
    override func updateTalent()
    {
        if -lastStreak.timeIntervalSinceNow > 0.01
        {
            let tempStreak=streak.copy() as! SKSpriteNode
            tempStreak.position=game!.player!.playerSprite!.position
            tempStreak.run(SKAction.move(by: CGVector(dx: random(min: -100, max: 100), dy: random(min: -100, max: 100)), duration: 0.5))
            tempStreak.run(SKAction.sequence([SKAction.rotate(byAngle: 6, duration: 0.5),SKAction.removeFromParent()]))
            tempStreak.colorBlendFactor=1.0
            tempStreak.color=NSColor(calibratedRed: random(min: 0.5, max: 1.0), green: random(min: 0.5, max: 1.0), blue: random(min: 0.5, max: 1.0), alpha: 1.0)
            tempStreak.alpha=random(min: 0.7, max: 0.7)
            tempStreak.zPosition=8
            game!.scene!.addChild(tempStreak)
            lastStreak=NSDate()
        }
        // print(activeLengthLeft())
    }
    override func doTalent()
    {
        if game != nil
        {
            if getCooldown() < 0
            {
                game!.player!.moveSpeed*=dashSpeed
                lastUse=NSDate()
                isActive=true
            } // if not on cooldown
        } // if the game not nil
    } // doTalent()
    
} // class DashTalentClass
