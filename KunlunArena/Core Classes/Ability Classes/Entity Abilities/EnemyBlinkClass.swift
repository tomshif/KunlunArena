//
//  EnemyBlinkClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 2/10/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyBlinkClass:EnemySkillClass
{
    override init(theGame: GameClass, ent: EntityClass)
    {
        super.init(theGame: theGame, ent: ent)
        
        manaCost=10
        COOLDOWN=5
        lengthActive=0
        tier=0
    } // init
    
    override func doSkill()
    {
        var allGood:Bool=false
        var dx:CGFloat=0
        var dy:CGFloat=0
        var tries:Int=0
        var xSpot:CGFloat=0
        var ySpot:CGFloat=0
        lastUse=NSDate()
        
        while (!allGood)
        {
            // pick a random direction
            let angle=random(min: 0, max: CGFloat.pi*2)
            
            // pick a distance
            let distance=random(min: 100, max: 300)
            
            // compute dx/dy
            dx=cos(angle)*distance
            dy=sin(angle)*distance
            
            xSpot=entity!.bodySprite.position.x + dx
            ySpot=entity!.bodySprite.position.y+dy
            
            for node in game!.scene!.nodes(at: CGPoint(x: xSpot, y: ySpot))
            {
                if node.name != nil
                {
                    if node.name!.contains("Floor")
                    {
                        // we're on the floor, so we're good
                        allGood=true
                        break
                    } // if it's a floor tile
                    
                } // if the name isn't nil
                
            } // for each node at the point
            
            tries+=1
            if tries > 10
            {
                allGood=true
                xSpot=entity!.bodySprite.position.x
                ySpot=entity!.bodySprite.position.y
                print("Blink failover")
            }
        } // while we're not all good
        
        // Now that we have found a spot, teleport to it
        entity!.bodySprite.position=CGPoint(x: xSpot, y: ySpot)
        
    } // doSkill()
    
} // EnemyBlinkClass
