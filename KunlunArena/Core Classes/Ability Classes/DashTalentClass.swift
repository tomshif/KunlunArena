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
    
    override init(theGame: GameClass)
    {
        super.init(theGame: theGame)
        name="Dash"
        isAction=true
        game=theGame
        COOLDOWN=0.75
    } // init game
    
    override func doTalent()
    {
        if game != nil
        {
            if -lastUse.timeIntervalSinceNow > COOLDOWN
            {
                let dx=cos(game!.player!.playerSprite!.zRotation)*dashDistance
                let dy=sin(game!.player!.playerSprite!.zRotation)*dashDistance
                let dashAction = SKAction.move(by: CGVector(dx: dx, dy: dy), duration: 0.25)
                game!.player!.playerSprite!.run(dashAction)
                lastUse=NSDate()
            } // if not on cooldown
        } // if the game not nil
    } // doTalent()
    
} // class DashTalentClass
