//
//  HubMapClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 2/4/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class HubMapClass:MapClass
{
    override init(width:Int, height:Int, theScene: GameScene, theGame:GameClass)
    {
        super.init(width: width, height: height, theScene: theScene, theGame: theGame)
        scene=theScene // a pointer to our scene
        game=theGame
        mapWidth=width
        mapHeight=height
        mapType=MapTypes.Hub
        
        playerArrow.zPosition=100
        playerArrow.setScale(0.1)
        
        ONEBLOCKWIDE=random(min: 0.1, max: 0.9)
        
        // create empty map
        for _ in 0..<height
        {
            for _ in 0..<width
            {
                
                mapGrid.append(0)
            } // for x
        } // for y

        floorType=Int(random(min: 0, max: 3.999999999))
            
        // create the map
        //createMap()
        
        // draw grid
        //drawMap()
        
        startRoomIndex=0
        endRoomIndex=roomPoints.count-1
        
    } // init()
    
    override func createMap()
     {
        // Create the rectangular layout for the Hub.
        for y in 0..<mapHeight
        {
            for x in 0..<mapWidth
            {
                if x > 4 && x < mapWidth-4 && y > 8 && y < mapHeight-8
                {
                    mapGrid[convertXY(x: x, y: y)]=2
                    
                } // if we're in the middle
                
            } // for x
        } // for y
        roomPoints.append((x: mapWidth/2, y: mapHeight/2))
         // mark off walls
         for y in 0..<mapHeight
         {
             for x in 0..<mapWidth
             {
                 if mapGrid[convertXY(x: x, y: y)] != 2
                 {
                     // check above
                     if y < mapHeight-1
                     {
                         if mapGrid[convertXY(x: x, y: y+1)] == 2
                         {
                             mapGrid[convertXY(x: x, y: y)] = 1
                         }
                     } // if
                     
                     // check right
                     if x < mapWidth-1
                     {
                         if mapGrid[convertXY(x: x+1, y: y)] == 2
                         {
                             mapGrid[convertXY(x: x, y: y)] = 1
                         }
                     } // if
                     
                     // check left
                     if x > 0
                     {
                         if mapGrid[convertXY(x: x-1, y: y)] == 2
                         {
                             mapGrid[convertXY(x: x, y: y)] = 1
                         }
                     } // if
                     
                     // check below
                     if y > 0
                     {
                         if mapGrid[convertXY(x: x, y: y-1)] == 2
                         {
                             mapGrid[convertXY(x: x, y: y)] = 1
                         }
                     } // if
                     
                     // check below left
                     if y > 0 && x > 0
                     {
                         if mapGrid[convertXY(x: x-1, y: y-1)] == 2
                         {
                             mapGrid[convertXY(x: x, y: y)] = 1
                         }
                     } // if
                     
                     // check above right
                     if y < mapHeight-1 && x < mapWidth-1
                     {
                         if mapGrid[convertXY(x: x+1, y: y+1)] == 2
                         {
                             mapGrid[convertXY(x: x, y: y)] = 1
                         }
                     } // if
                     
                     // check below right
                     if y > 0 && x < mapWidth-1
                     {
                         if mapGrid[convertXY(x: x+1, y: y-1)] == 2
                         {
                             mapGrid[convertXY(x: x, y: y)] = 1
                         }
                     } // if
                     
                     // check below left
                     if y < mapHeight-1 && x > 0
                     {
                         if mapGrid[convertXY(x: x-1, y: y+1)] == 2
                         {
                             mapGrid[convertXY(x: x, y: y)] = 1
                         }
                     } // if
                 } // if not a floor tile
             } // for x
         } // for y
        
        // Create Portal Icons
        let earthPortal=SKSpriteNode(imageNamed: "portalIcon")
        earthPortal.setScale(4.0)
        earthPortal.position.x = (-5*earthPortal.size.width)
        earthPortal.position.y = 0
        earthPortal.zPosition=5
        earthPortal.alpha=0.3
        earthPortal.name="hubEarthPortal"
        earthPortal.colorBlendFactor=1.0
        earthPortal.color=NSColor.brown
        scene!.addChild(earthPortal)
        earthPortal.run(SKAction.repeatForever(SKAction.sequence([SKAction.rotate(toAngle: CGFloat.pi/8, duration: 0.25),SKAction.rotate(toAngle: -CGFloat.pi/8, duration: 0.25)])))
         let earthEmitter=SKEmitterNode(fileNamed: "PortalEmitter.sks")
        earthEmitter!.particleColorBlendFactor=1
        earthEmitter!.particleColorSequence=nil
        earthEmitter!.particleColor=NSColor.brown
        earthEmitter!.position=earthPortal.position
        earthEmitter!.zPosition=7
        earthEmitter!.setScale(1.5)
        earthEmitter!.name="hubEarthEmitter"
        scene!.addChild(earthEmitter!)
        
        let firePortal=SKSpriteNode(imageNamed: "portalIcon")
        firePortal.setScale(4.0)
        firePortal.position.y = (3*firePortal.size.height)
        firePortal.position.x = 0
        firePortal.zPosition=5
        firePortal.alpha=0.3
        firePortal.name="hubFirePortal"
        firePortal.colorBlendFactor=1.0
        firePortal.color=NSColor.red
        scene!.addChild(firePortal)
    firePortal.run(SKAction.repeatForever(SKAction.sequence([SKAction.rotate(toAngle: CGFloat.pi/12, duration: 0.25),SKAction.rotate(toAngle: -CGFloat.pi/12, duration: 0.25)])))
        
         let fireEmitter=SKEmitterNode(fileNamed: "PortalEmitter.sks")
        fireEmitter!.particleColorBlendFactor=1
        fireEmitter!.particleColorSequence=nil
        fireEmitter!.particleColor=NSColor.red
        fireEmitter!.position=firePortal.position
        fireEmitter!.zPosition=7
        fireEmitter!.setScale(1.5)
        fireEmitter!.name="hubFireEmitter"
        scene!.addChild(fireEmitter!)
        
     } // func createMap()

    
} // HubMapClass
