//
//  EntityClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class EntityClass
{
    var scene:SKScene?
    var game:GameClass?
    
    var name:String
    var headNum:Int
    var bodyNum:Int
    var legsNum:Int
    var headSprite=SKSpriteNode()
    var bodySprite=SKSpriteNode()
    
    var moveSpeed:CGFloat=5.0
    
    let UPDATECYCLE:Int=0
    
    init()
    {
        name="Test"
        headNum=0
        bodyNum=0
        legsNum=0
        headSprite=SKSpriteNode(imageNamed: "head")
        bodySprite=SKSpriteNode(imageNamed: "body")
        
    } // init() - default
    
    init(theScene: SKScene)
    {
        scene=theScene
        name="Test"
        headNum=0
        bodyNum=0
        legsNum=0
        headSprite=SKSpriteNode(imageNamed: "head")
        bodySprite=SKSpriteNode(imageNamed: "body")
        bodySprite.colorBlendFactor=1.0
        bodySprite.color=NSColor.red
        bodySprite.position.x=scene!.size.height/2
        bodySprite.position.y=scene!.size.width/2
        scene!.addChild(bodySprite)
        bodySprite.addChild(headSprite)
        bodySprite.name="entBody"
        headSprite.name="entHead"
        bodySprite.zPosition=10
        headSprite.zPosition=11
        moveSpeed=random(min: 3.5, max: 8.5)
    } // init(scene)
    
    public func update(cycle: Int)
    {
        if UPDATECYCLE==cycle
        {
            // Simple Follow logic - target player
 
            // get direction to player
            let dx=game!.player!.playerSprite!.position.x - bodySprite.position.x
            let dy=game!.player!.playerSprite!.position.y - bodySprite.position.y
            let angle=atan2(dy,dx)
            
            // Turn towards player
            bodySprite.zRotation=angle
            
            // Compute distance to player
            let dist=hypot(dy, dx)
            
        } // if it's our time to update
            
        // move towards player

        let moveDX=cos(bodySprite.zRotation)*moveSpeed
        let moveDY=sin(bodySprite.zRotation)*moveSpeed
        bodySprite.position.x += moveDX
        bodySprite.position.y += moveDY
        
    } // update()
    
} // class EntityClass


