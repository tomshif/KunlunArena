//
//  MapClass.swift
//  DungeonGen02
//
//  Created by Tom Shiflet on 12/25/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This class is the base class for creating map levels. This class itself will never be used in game and only subclasses of this class will be used.
// Sub classes should modify variables and override the drawMap() function (copy/paste then change is probably the easiest).
// The parameter line of the init() CANNOT be changed in order to keep class polymorphism.
// If the dungeon layout needs to be changed drastically, the init() can be overridden but very special circumstances apply and things can break very easily because of the requirement to call the super class init().

import Foundation
import SpriteKit

class MapClass
{
    var mapGrid=[Int]()
    var scene:GameScene?
    var game:GameClass?
    var miniMap:SKSpriteNode?
    var mapType:Int=MapTypes.Rat
    
    var mapWidth:Int=0 // in tile grid spaces
    var mapHeight:Int=0
    
    // An array of the map tile coords for each room (based on the bottom left corner of each room)
    var roomPoints=[(x: Int,y: Int)]()
    
    // These save the start room (where the player will spawn), the end room (where the exit will be) and the largest room (Where the mini-boss / boss will be).
    var startRoomIndex:Int=0
    var endRoomIndex:Int=0
    var largestRoomIndex:Int=0
    
    var floorType:Int=0
    
    var roomNum:Int=0
    
    
    var TILESIZE:CGFloat=0 // set in init() to the width of the tile sprite (after scaling)
    
    var ROOMDISTANCE:Int=12 // This is how far apart the rooms must be in order to be allowed to be placed. This is the minimum distance (in tiles) from the bottom left corner of one room to the bottom left corner of the other room. If this number is too high, the game will lock up as there is no failsafe to bail out on the search...maybe we should add that?
    
    
    
    let TILESCALE:CGFloat=6.0 // How much to scale the ground tiles...make sure that all ground tiles are the same size or things get wonky.
    
    

    var ONEBLOCKWIDE:CGFloat=0.00    // This used for determining width of hallways it rolls a number 0-1.0 and based on the value of this variable if the roll is HIGHER than this number, the hallway is two blocks wide instead of one. This is reset in the init() (currently randomized but to be customized for different subclasses).
    
        // This is the number of enemies that spawn into a given map.
        // The number of enemies present is computed as follows
        // numEnemies = mapWidth*mapHeight/ENTSPAWNFACTOR
        // As an example, a 96x96 map with a spawn factor of 50:
        // 96x96 / 50
        // 9216 / 50
        // 184
        // We need to keep enemies under 200ish
        var ENTSPAWNFACTOR:Int=50
    
        var playerArrow=SKSpriteNode(imageNamed: "smallRedArrow")
    
    
    init(width:Int, height:Int, theScene: GameScene, theGame:GameClass)
    {
        scene=theScene // a pointer to our scene
        game=theGame
        mapWidth=width
        mapHeight=height
        miniMap=SKSpriteNode(imageNamed: "miniMapFrame")
        miniMap!.position.x=scene!.size.width*0.3
        miniMap!.position.y=scene!.size.height*0.3
        miniMap!.zPosition=12000
        miniMap!.name="miniMap"
        game!.cam!.addChild(miniMap!)
        playerArrow.zPosition=100
        playerArrow.setScale(0.1)
        miniMap!.addChild(playerArrow)
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
        createMap()
        
        // draw grid
        drawMap()
        
        startRoomIndex=0
        endRoomIndex=roomPoints.count-1
        
    } // init()
    
    
    internal func createMap()
    {
        // ** choose number of rooms **
        // This is chosen based on the size of the map.
        // Bigger maps will have more rooms (on average)
        // For example: 64*64 = 4096, divide this by:
        // 256 = 16
        // 341 = 12
        // 512 = 8
        // 768 = 5
        // 1024 = 4
        //
        // But if we have a 96x96 map, that gives us 9216:
        // 256 = 36
        // 341 = 27
        // 512 = 18
        // 768 = 12
        // 1024 = 9
        //
        // The random range can give a unique feel to the maps and should be customized for subclasses
        
        roomNum=Int(random(min:CGFloat(mapWidth*mapHeight)/768, max: CGFloat(mapWidth*mapHeight)/341))
        
        
        // pick the location for the rooms
        
        for _ in 1...roomNum
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
                        
                        
                        // The room distance can GREATLY alter the look of the level
                        // because if the rooms can be close together
                        // then there will be a lot of overlap, turning two
                        // or more rooms into one really big room
                        // This is variable so that it can be altered in
                        // subclasses but should not be altered within a given
                        // subclass so that levels of the same subclass
                        // maintain a consistent feel.
                        
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
            let roomWidth:Int=Int(random(min:8, max: 16))
            let roomHeight:Int=Int(random(min:8, max: 16))
            
            if i > 0
            {
                let size=roomWidth*roomHeight
                if size > largestSize
                {
                    largestSize=size
                    largestRoomIndex=i
                }
            } // save the largest sized room that isn't the first room

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
        //
        // We'll randomly choose whether to draw the horizontal or vertical
        // connecting path first. We'll draw that path, then the other
        //
        
        for i in 0..<roomPoints.count-1
        {
            // compute variances
            let dy = roomPoints[i].y - roomPoints[i+1].y
            let dx = roomPoints[i].x - roomPoints[i+1].x
            
            // Choose whether this is a one block or two block wide path
            let HALLWIDTH=random(min: 0, max: 1) // if this is greater than our ONEBLOCKWIDE value, then the hall is two wide
            
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
                        
                        // if two block wide, add one to the right
                        if HALLWIDTH >= ONEBLOCKWIDE
                        {
                        mapGrid[(roomPoints[i].y-yPath)*mapWidth+roomPoints[i].x+1]=2
                        } // if it is a double hallway
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
        
    } // func createMap()
    
    internal func drawMap()
    {
        var wallString:String=""
        switch floorType
        {
        case 0:
            wallString="wall"
            
        case 1:
            wallString="yellowWall"
            
        default:
            wallString="wall"
            
        }
        for y in 0..<mapHeight
        {
            for x in 0..<mapWidth
            {
                switch mapGrid[x+y*mapHeight]
                {
                    
                case 1: // blocked grid
                    let tempFloor=SKSpriteNode(imageNamed: "\(wallString)00")
                    tempFloor.setScale(TILESCALE)
                    tempFloor.zPosition=1
                    tempFloor.lightingBitMask=1
                    tempFloor.position.x = (CGFloat(x)*tempFloor.size.width) - (CGFloat(mapWidth)*tempFloor.size.width)/2
                    tempFloor.position.y = (CGFloat(y)*tempFloor.size.height) - (CGFloat(mapHeight)*tempFloor.size.width)/2
                    tempFloor.name="dngBlock"
                    tempFloor.texture!.filteringMode=SKTextureFilteringMode.nearest
                    
                    tempFloor.physicsBody=SKPhysicsBody(rectangleOf: tempFloor.size)
                    tempFloor.physicsBody!.usesPreciseCollisionDetection=true
                    tempFloor.physicsBody!.isDynamic=false
                    tempFloor.physicsBody!.affectedByGravity=false
                    tempFloor.physicsBody!.categoryBitMask=BODYBITMASKS.WALL
                    tempFloor.physicsBody!.collisionBitMask=BODYBITMASKS.ENEMY
                    scene!.addChild(tempFloor)
                    TILESIZE=tempFloor.size.width
                    
                    // add Floor tile to minimap
                    

                    
                    
                    // check for texture variance
                    let chance=random(min: 0, max: 1)
                    if chance > 0.85
                    {
                        let skin=Int(random(min:1, max: 4.9999999))
                        tempFloor.texture=SKTexture(imageNamed: "\(wallString)0\(skin)")
                    } // if chance
                    
                case 2: // room floor
                    
                    let tempFloor=SKSpriteNode(imageNamed: "stoneFloor00")
                    tempFloor.lightingBitMask=1
                    if floorType==1
                    {
                        tempFloor.texture=SKTexture(imageNamed: "dirtFloor00")
                        scene!.myLight.lightColor=NSColor(calibratedRed: 0.6, green: 1.0, blue: 1.0, alpha: 1.0)
                    }
                    else if floorType==2
                    {
                        let floorType:CGFloat=random(min: 0, max: 90)
                            var suffixFloor:String=""

                            if floorType>=0 && floorType<3 {
                                suffixFloor="00"
                            }

                            if floorType>=3 && floorType<10 {
                                suffixFloor="01"
                            }
                           if floorType>=10 && floorType<=90 {
                                suffixFloor="02"
                            }
                         let name:String="lavaFloor"+suffixFloor
                        //randomizes the floor pattern
                        tempFloor.texture=SKTexture(imageNamed: name)
                       
                        scene!.myLight.lightColor=NSColor(calibratedRed: 1.0, green: 0.7, blue: 0.7, alpha: 1.0)
                        //scene!.myLight.ambientColor=NSColor(calibratedRed: 0.01, green: 0.0, blue: 0.0, alpha: 1.0)
                    }
                    else if floorType==3
                    {
                        
                        tempFloor.texture=SKTexture(imageNamed: "purpleFloor00")
                    }
                    
                    tempFloor.setScale(TILESCALE)
                    tempFloor.zPosition=1
                    tempFloor.position.x = (CGFloat(x)*tempFloor.size.width) - (CGFloat(mapWidth)*tempFloor.size.width)/2
                    tempFloor.position.y = (CGFloat(y)*tempFloor.size.height) - (CGFloat(mapHeight)*tempFloor.size.width)/2
                    tempFloor.name="dngFloor"
                    tempFloor.texture!.filteringMode=SKTextureFilteringMode.nearest
                    
                    var rotationType:Int=(Int(random(min: 0, max: 4.99999999999999999999999999999999999)))
                    
                    if rotationType==1{
                     tempFloor.zRotation = CGFloat.pi/2
                    }
                    if rotationType==2{
                     tempFloor.zRotation = CGFloat.pi
                    }
                    if rotationType==3{
                     tempFloor.zRotation = (CGFloat.pi*3)/2
                    }
                    if rotationType==4{
                     tempFloor.zRotation = 2*CGFloat.pi
                    }

                    scene!.addChild(tempFloor)
                    TILESIZE=tempFloor.size.width
                    let miniFloor=SKSpriteNode(imageNamed: "stoneFloor00")
                    miniFloor.setScale(0.15)
                    miniMap!.addChild(miniFloor)
                    print("MiniFloorSize: \(miniFloor.size.width)")
                    miniFloor.position.x = (CGFloat(x)*miniFloor.size.width) - (CGFloat(mapWidth)*miniFloor.size.width)/2
                    miniFloor.position.y = (CGFloat(y)*miniFloor.size.height) - (CGFloat(mapHeight)*miniFloor.size.width)/2
 
                    print(miniFloor.position)
                    miniFloor.zPosition=5
                    
                    print("mini count: \(miniMap!.children.count)")
                    
                    
                default:
                    break
                    
                } // switch
            } // for x
        } // for y
    } // func drawMap()
    
    internal func convertXY(x: Int, y:Int) -> Int
    {
        return y*mapWidth+x
    } // func convertXY()
    
} // MapClass
