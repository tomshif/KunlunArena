//
//  MapClass.swift
//  DungeonGen02
//
//  Created by Tom Shiflet on 12/25/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class MapClass
{
    var mapGrid=[Int]()
    var scene:GameScene?
    
    var mapWidth:Int=0
    var mapHeight:Int=0
    
    var roomPoints=[(x: Int,y: Int)]()
    
    var startRoomIndex:Int=0
    var endRoomIndex:Int=0
    var largestRoomIndex:Int=0
    var roomNum:Int=0
    var TILESIZE:CGFloat=0
    
    let ROOMDISTANCE:Int=8
    let TILESCALE:CGFloat=8.0
    
    let ONEBLOCKWIDE:CGFloat=0.65 // used for determining width of hallways
    
    
    
    
    init(width:Int, height:Int, theScene: GameScene)
    {
        scene=theScene
        
        mapWidth=width
        mapHeight=height
        
        
        // create empty map
        for y in 0..<height
        {
            for x in 0..<width
            {
                
                mapGrid.append(0)
            } // for x
        } // for y

        
        // create the map
        createMap()
        
        // draw grid
        drawMap()
        
        startRoomIndex=0
        endRoomIndex=roomPoints.count-1
        
    } // init()
    
    
    private func createMap()
    {
        // choose number of rooms
        roomNum=Int(random(min:CGFloat(mapWidth*mapHeight)/512, max: CGFloat(mapWidth*mapHeight)/384))
        
        // pick the location for the rooms
        
        
        for i in 1...roomNum
        {
            var goodSpot:Bool=false
            
            var roomX:Int=0
            var roomY:Int=0
            while (!goodSpot)
            {
                goodSpot=true
                roomX=Int(random(min: 4, max: CGFloat(mapWidth)-4))
                roomY=Int(random(min: 4, max: CGFloat(mapHeight)-4))
                
                // check for rooms nearby
                if roomPoints.count > 0
                {
                    for room in roomPoints
                    {
                        let dx = room.x - roomX
                        let dy = room.y - roomY
                        let dist=Int(hypot(CGFloat(dy), CGFloat(dx)))
                        
                        
                        if dist <= ROOMDISTANCE
                        {
                            goodSpot=false

                        }
                    } // for each room that already exists
                } // if we have rooms to compare to

            } // while we are still looking for a good spot
            
            mapGrid[roomX+roomY*mapWidth]=2
            roomPoints.append((x: roomX, y: roomY))
            
            
        } // for each room that we're spawning
        
        // Next we need to build out rooms of different sizes
        var largestSize:Int=0
        for i in 0..<roomPoints.count
        {
            let roomWidth:Int=Int(random(min:4, max: 13))
            let roomHeight:Int=Int(random(min:4, max: 13))
            
            if i > 0
            {
                let size=roomWidth*roomHeight
                if size > largestSize
                {
                    largestSize=size
                    largestRoomIndex=i
                }
            }

            // adjust the grid to show room floors
            for y in 0..<roomHeight
            {
                for x in 0..<roomWidth
                {
                    
                    let dx=roomPoints[i].x + x
                    let dy=roomPoints[i].y + y
                    if dy < mapHeight-1 && dx < mapWidth-1
                    {
                        mapGrid[dy*mapWidth+dx]=2
                    } // This is a messy way to avoid a crash. Needs to be cleaner by choosing rooms that are NOT right next to the edge
                } // for x
            } // for y
            
            
        } // for each room
        
        
        // Next we draw the connecting paths to room to room
        
        for i in 0..<roomPoints.count-1
        {
            // compute variances
            let dy = roomPoints[i].y - roomPoints[i+1].y
            let dx = roomPoints[i].x - roomPoints[i+1].x
            
            // Choose whether this is a one block or two block wide path
            let HALLWIDTH=random(min: 0, max: 1) // 0..<0.75 = 1, 0.75 - 1.0 = 2
            
            // choose to draw vertical or horizontal path first
            let choice=random(min:0, max: 1)
            if choice < 0.5
            {
                if dy > 0
                {
                    // draw vertical path first
                    for yPath in 0..<dy
                    {

                        mapGrid[(roomPoints[i].y-yPath)*mapWidth+roomPoints[i].x]=2
                        print("Floor path=\((roomPoints[i].y-yPath)*mapWidth+roomPoints[i].x)")
                        // if two block wide, add one to the right
                        if HALLWIDTH >= ONEBLOCKWIDE
                        {
                            print("Extra path=\((roomPoints[i].y-yPath)*mapWidth+roomPoints[i].x+1)")
                        mapGrid[(roomPoints[i].y-yPath)*mapWidth+roomPoints[i].x+1]=2
                        }
                    } // for each y difference
                } // if drawing up
                else if dy < 0
                {
                    for yPath in 0 ..< (-dy)
                    {

                        mapGrid[(roomPoints[i].y+yPath)*mapWidth+roomPoints[i].x]=2
                        
                        // if two block wide, add one to the right
                        if HALLWIDTH >= ONEBLOCKWIDE
                        {
                        mapGrid[(roomPoints[i].y+yPath)*mapWidth+roomPoints[i].x+1]=2
                        }
                    } // for each y difference
                } // else if drawing down
                
                // next draw horizontal
                
                if dx > 0
                {
                    for xPath in 0..<dx
                    {
                            
                        mapGrid[(roomPoints[i].y-dy)*mapWidth+roomPoints[i].x-xPath]=2
                        if HALLWIDTH > ONEBLOCKWIDE
                        {
                        mapGrid[(roomPoints[i].y-dy)*(mapWidth)+roomPoints[i].x-xPath+mapWidth]=2
                        }

                    } // for each y difference
                }
                else if dx < 0
                {
                    for xPath in 0 ..< -dx
                    {

                        

                        mapGrid[(roomPoints[i].y-dy)*mapWidth+roomPoints[i].x+xPath]=2
                        if HALLWIDTH > ONEBLOCKWIDE
                        {
                        mapGrid[(roomPoints[i].y-dy)*(mapWidth)+roomPoints[i].x+xPath+mapWidth]=2
                        }

                    } // for each y difference
                }
                
                
            } // if vertical first
            else
            {
                // draw horizontal path first
                
                if dx > 0
                {
                    for xPath in 0..<dx
                    {
                           
                        mapGrid[(roomPoints[i].y)*mapWidth+roomPoints[i].x-xPath]=2
                        if HALLWIDTH > ONEBLOCKWIDE
                        {
                        mapGrid[(roomPoints[i].y)*mapWidth+roomPoints[i].x-xPath+mapWidth]=2
                        }
                    } // for each y difference
                }
                else if dx < 0
                {
                    for xPath in 0 ..< -dx
                    {

                        
   
                        mapGrid[(roomPoints[i].y)*mapWidth+roomPoints[i].x+xPath]=2
                        if HALLWIDTH > ONEBLOCKWIDE
                        {
                        mapGrid[(roomPoints[i].y)*mapWidth+roomPoints[i].x+xPath+mapWidth]=2
                        }
                    } // for each y difference
                }
                
                if dy > 0
                 {
                     // draw vertical path
                     for yPath in 0..<dy
                     {

                         mapGrid[(roomPoints[i].y-yPath)*mapWidth+roomPoints[i].x-dx]=2
                        if HALLWIDTH > ONEBLOCKWIDE
                        {
                        mapGrid[(roomPoints[i].y-yPath)*mapWidth+roomPoints[i].x-dx+1]=2
                        }
                     } // for each y difference
                 } // if drawing up
                 else if dy < 0
                 {
                     for yPath in 0 ..< (-dy)
                     {

                         mapGrid[(roomPoints[i].y+yPath)*mapWidth+roomPoints[i].x-dx]=2
                        if HALLWIDTH > ONEBLOCKWIDE
                        {
                        mapGrid[(roomPoints[i].y+yPath)*mapWidth+roomPoints[i].x-dx+1]=2
                        }
                     } // for each y difference
                 } // else if drawing down
                 
                 // next draw horizontal
                 

                 
                
                
                
            } // if horizontal
            
        } // for each room
        
        
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
                    }
                    // check right
                    if x < mapWidth-1
                    {
                        if mapGrid[convertXY(x: x+1, y: y)] == 2
                        {
                            mapGrid[convertXY(x: x, y: y)] = 1
                        }
                    }
                    // check left
                    if x > 0
                    {
                        if mapGrid[convertXY(x: x-1, y: y)] == 2
                        {
                            mapGrid[convertXY(x: x, y: y)] = 1
                        }
                    }
                    
                    if y > 0
                    {
                        if mapGrid[convertXY(x: x, y: y-1)] == 2
                        {
                            mapGrid[convertXY(x: x, y: y)] = 1
                        }
                    }
                    
                    if y > 0 && x > 0
                    {
                        if mapGrid[convertXY(x: x-1, y: y-1)] == 2
                        {
                            mapGrid[convertXY(x: x, y: y)] = 1
                        }
                    }
                    if y < mapHeight-1 && x < mapWidth-1
                    {
                        if mapGrid[convertXY(x: x+1, y: y+1)] == 2
                        {
                            mapGrid[convertXY(x: x, y: y)] = 1
                        }
                    }
                    
                    if y > 0 && x < mapWidth-1
                    {
                        if mapGrid[convertXY(x: x+1, y: y-1)] == 2
                        {
                            mapGrid[convertXY(x: x, y: y)] = 1
                        }
                    }
                    if y < mapHeight-1 && x > 0
                    {
                        if mapGrid[convertXY(x: x-1, y: y+1)] == 2
                        {
                            mapGrid[convertXY(x: x, y: y)] = 1
                        }
                    }
                } // if not a floor tile
            } // for x
        } // for y
        
    }
    
    
    private func drawMap()
    {
        for y in 0..<mapHeight
        {
            for x in 0..<mapWidth
            {
                switch mapGrid[x+y*mapHeight]
                {
                    
                case 1: // blocked grid
                    let tempFloor=SKSpriteNode(imageNamed: "wall00")
                    tempFloor.setScale(TILESCALE)
                    tempFloor.zPosition=1
                    tempFloor.position.x = (CGFloat(x)*tempFloor.size.width) - (CGFloat(mapWidth)*tempFloor.size.width)/2
                    tempFloor.position.y = (CGFloat(y)*tempFloor.size.height) - (CGFloat(mapHeight)*tempFloor.size.width)/2
                    tempFloor.name="dngBlock"
                    tempFloor.texture!.filteringMode=SKTextureFilteringMode.nearest
                    
                    tempFloor.physicsBody=SKPhysicsBody(rectangleOf: tempFloor.size)
                    tempFloor.physicsBody!.isDynamic=false
                    tempFloor.physicsBody!.affectedByGravity=false
                    tempFloor.physicsBody!.categoryBitMask=BODYBITMASKS.WALL
                    tempFloor.physicsBody!.collisionBitMask=BODYBITMASKS.ENEMY
                    scene!.addChild(tempFloor)
                    TILESIZE=tempFloor.size.width
                    
                    // check for texture variance
                    let chance=random(min: 0, max: 1)
                    if chance > 0.85
                    {
                        let skin=Int(random(min:1, max: 4.9999999))
                        tempFloor.texture=SKTexture(imageNamed: "wall0\(skin)")
                    }
                    
                case 2: // room floor
                    
                    let tempFloor=SKSpriteNode(imageNamed: "floor")
                    tempFloor.setScale(TILESCALE)
                    tempFloor.zPosition=1
                    tempFloor.position.x = (CGFloat(x)*tempFloor.size.width) - (CGFloat(mapWidth)*tempFloor.size.width)/2
                    tempFloor.position.y = (CGFloat(y)*tempFloor.size.height) - (CGFloat(mapHeight)*tempFloor.size.width)/2
                    tempFloor.name="dngFloor"
                    tempFloor.texture!.filteringMode=SKTextureFilteringMode.nearest

                    scene!.addChild(tempFloor)
                    TILESIZE=tempFloor.size.width
                default:
                    break
                    
                } // switch
            } // for x
        } // for y
    }
    private func convertXY(x: Int, y:Int) -> Int
    {
        return y*mapWidth+x
    }
    
} // MapClass
