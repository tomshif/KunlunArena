//
//  GameScene.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import SpriteKit
import GameplayKit


// Global externals


class GameScene: SKScene {
    
    let BUILDVERSION:String="Tech Demo 0.05a"
    
    // SK Nodes
    var cam=SKCameraNode()
    var pBody=SKSpriteNode(imageNamed: "body")
    var pHead=SKSpriteNode(imageNamed: "head")
    var pArms=SKSpriteNode(imageNamed: "arms")

    var stateLabel=SKLabelNode(fontNamed: "Chalkduster")
    var entCountLabel=SKLabelNode(fontNamed: "Arial")
    var copyrightLabel=SKLabelNode(text: "(C) LCS Game Design, 2020.")
    var buildLabel=SKLabelNode(fontNamed: "Arial")
    
    var entCountBG=SKShapeNode()
    
    var bgParticle=SKEmitterNode() // This looks crappy, needs to be different
    
    var myLight=SKLightNode()
    
      
    
    // Ints
    var updateCycle:Int=0
    var entCount:Int=0
    var gameState:Int=STATES.FIGHT
    var MAPSIZE:Int=90
    
    // Core Classes
    var game=GameClass()
 
    
    // KB Bools
    var upPressed:Bool=false
    var leftPressed:Bool=false
    var rightPressed:Bool=false
    var downPressed:Bool=false
    var mousePressed:Bool=false
    var zoomOutPressed:Bool=false
    var zoomInPressed:Bool=false
    

    // CONSTANTS
    let MAXAICYCLES:Int=4
    var NUMENEMIES:Int=0
    
    // Temp Variables
    //var tempEnt=EntityClass()
    var player=PlayerClass() // Needs to go in GameClass
    

    var tempMap:MapClass?
    
    
    
    
    override func didMove(to view: SKView) {
        
        
        
        
        MAPSIZE=Int(random(min:64, max: 96))
        
        //addChild(myLight)
        myLight.falloff=1
        
        // Init Camera and BG
        addChild(cam)
        self.camera=cam
        self.backgroundColor=NSColor.black
        
        // Gen Map
        tempMap=MapClass(width: MAPSIZE, height: MAPSIZE, theScene: self)
        NUMENEMIES=MAPSIZE*MAPSIZE/tempMap!.ENTSPAWNFACTOR
        
        // Setup Labels
        copyrightLabel.position.y = -size.height*0.475
        copyrightLabel.position.x = -size.width*0.385
        copyrightLabel.fontName="Arial"
        copyrightLabel.fontSize=16
        copyrightLabel.fontColor=NSColor.red
        cam.addChild(copyrightLabel)
        copyrightLabel.zPosition=10000
        
        buildLabel.position.x = size.width*0.4
        buildLabel.position.y = -size.height*0.45
        buildLabel.zPosition = 10000
        buildLabel.text="Build: \(BUILDVERSION)"
        buildLabel.fontColor=NSColor.red
        buildLabel.fontSize=16
        cam.addChild(buildLabel)
        
        stateLabel.fontSize=40
        stateLabel.position.y=size.height*0.45
        stateLabel.text="Play State"
        stateLabel.zPosition=10000
        stateLabel.fontColor=NSColor.red
        cam.addChild(stateLabel)
        
        entCountBG=SKShapeNode(rectOf: CGSize(width: 100, height: 30))
        entCountBG.fillColor=NSColor.black
        entCountBG.alpha=0.50
        entCountBG.zPosition=10001
        entCountBG.position.x = -size.width*0.43
        entCountBG.position.y = size.height*0.45
        cam.addChild(entCountBG)
        
        entCountLabel.position.x = -size.width*0.43
        entCountLabel.position.y = size.height*0.4375
        entCountLabel.fontSize = 28
        entCountLabel.fontColor=NSColor.white
        entCountLabel.zPosition=10002
        entCountLabel.text="435"
        cam.addChild(entCountLabel)
        
        bgParticle=SKEmitterNode(fileNamed: "SmokeBG.sks")!
        addChild(bgParticle)
        bgParticle.setScale(4.0)
        
        
        // Init the game
        game=GameClass(theScene: self)

        player=PlayerClass(theGame: game)
        game.player=player
        gameState=STATES.FIGHT
        player.playerSprite=pBody
        
        // Setup the player sprite (needs to be moved to PlayerClass init)
        addChild(pBody)
        pBody.addChild(pHead)
        pBody.addChild(pArms)
        pBody.zPosition=2
        pHead.zPosition=3
        pArms.zPosition=3
        
        // create player physics body
        pBody.physicsBody=SKPhysicsBody(circleOfRadius: pBody.size.width)
        pBody.physicsBody!.categoryBitMask=BODYBITMASKS.PLAYER
        pBody.physicsBody!.collisionBitMask=BODYBITMASKS.WALL
       
        pBody.physicsBody!.usesPreciseCollisionDetection=true
        pBody.physicsBody!.affectedByGravity=false
        
        // Start the player in room #1 of the map
        player.playerSprite!.position.x = CGFloat(tempMap!.roomPoints[tempMap!.startRoomIndex].x)*tempMap!.TILESIZE - (CGFloat(tempMap!.mapWidth)*tempMap!.TILESIZE) / 2
        player.playerSprite!.position.y = CGFloat(tempMap!.roomPoints[tempMap!.startRoomIndex].y)*tempMap!.TILESIZE - (CGFloat(tempMap!.mapHeight)*tempMap!.TILESIZE)/2
        
        
        // create a bunch of temp entities
        for _ in 1...NUMENEMIES
        {
            spawnEnemy()
        } // for
        
        
    } // didMove()
    
    func spawnEnemy()
    {
        let tempEnt=TestEntClass(theScene: self, id: entCount)
        tempEnt.game=game
        var goodSpawn:Bool=false
        var xp:CGFloat=0
        var yp:CGFloat=0
        while !goodSpawn
        {
            xp=random(min: -CGFloat(tempMap!.mapWidth)*tempMap!.TILESIZE/2, max: CGFloat(tempMap!.mapWidth)*tempMap!.TILESIZE/2)
            yp=random(min: -CGFloat(tempMap!.mapHeight)*tempMap!.TILESIZE/2, max: CGFloat(tempMap!.mapHeight)*tempMap!.TILESIZE/2)
            // get distance to player
            let dx = xp - player.playerSprite!.position.x
            let dy = yp - player.playerSprite!.position.y
            let pDist = hypot(dy,dx)
            
            
            for node in self.nodes(at: CGPoint(x: xp, y: yp))
            {
                if node.name != nil
                {
                    if node.name!.contains("Floor") && pDist > 1000
                    {
                        goodSpawn=true
                    }
                } // if not nil
            } // for each node at the spot
        } // while we're looking for a good spawn point
        tempEnt.bodySprite.position.x=xp
        tempEnt.bodySprite.position.y=yp
        game.entList.append(tempEnt)
        entCount+=1
    } // func spawnEnemy()
    
    func attack()
    {
        
        // This is a temp function that needs to be replaced with a talent class
        let tempSplode=SKEmitterNode(fileNamed: "FireSplode.sks")
        tempSplode!.position=player.playerSprite!.position
        tempSplode!.zPosition=10
        tempSplode!.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),SKAction.removeFromParent()]))
        addChild(tempSplode!)
        tempSplode!.setScale(2.0)
        myLight.run(SKAction.sequence([SKAction.falloff(to: 0.1, duration: 0.8),SKAction.falloff(to: 2.5, duration: 0.2)]))
        for node in self.children
        {
            if node.name != nil
            {
                if node.name!.contains("ent")
                {
                    let dx=player.playerSprite!.position.x - node.position.x
                    let dy=player.playerSprite!.position.y - node.position.y
                    let dist = hypot(dy, dx)
                    if dist < 500
                    {
                        // find in entList
                        for ent in game.entList
                        {
                            if ent.bodySprite.name! == node.name!
                            {
                                ent.die()
                               
                            } // we found the entity, kill it
                        } // for each entity
                        
                    } // if in range
                } // if ent
            } // if name not nil
        } // for each node
    } // attack()

    
    func drawGrid()
    {
        // This is used if you just want a blank grid instead of the actual level.
        let gridWidth:Int=32
        
        for y in 1...gridWidth
        {
            for x in 1...gridWidth
            {
                let tempGrid=SKSpriteNode(imageNamed: "bgGrid")
                tempGrid.position.x = CGFloat(x-gridWidth/2)*(tempGrid.size.width)
                tempGrid.position.y = CGFloat(y-gridWidth/2)*tempGrid.size.height
                tempGrid.zPosition=0
                tempGrid.name="tempGridFloor"
                addChild(tempGrid)
            } // for x
        } // for y
    } // drawGrid()
    
    func touchDown(atPoint pos : CGPoint) {
        
        if gameState==STATES.FIGHT
        {
            // Currently a test of click to move...not sure I like this...maybe remove it?
            mousePressed=true
            let dx=pos.x-pBody.position.x
            let dy=pos.y-pBody.position.y
            let angle=atan2(dy,dx)
            pBody.zRotation=angle
            //player.moveToPoint=pos
            //player.isMovingToPoint=true
            
            if player.playerTalents[0].getCooldown() < 0
            {
                player.playerTalents[0].doTalent()
            } // if we're not on cooldown
        } // if play state
        /*
        else if gameState==STATES.FIGHT  && player.isInAttackMode
        {
            // Check cooldown
            if player.playerTalents[0].getCooldown() < 0
            {
                // rotate the player to the point
                let angle=atan2(pos.y-player.playerSprite!.position.y, pos.x-player.playerSprite!.position.x)
                player.playerSprite!.zRotation=angle
                player.playerTalents[0].doTalent()
            } // if we're not on cooldown
            else
            {
                print("Attack on cooldown.")
            }
        } // if we're in attack mode
        */
        else if gameState==STATES.SPAWNWALL
        {
            for x in 0..<10
            {
                let tempWall=SKSpriteNode(imageNamed: "wall00")
                tempWall.setScale(3.0)
                tempWall.position.y=pos.y
                tempWall.position.x = pos.x + (CGFloat(x)*tempWall.size.width)
                tempWall.zPosition=10
                tempWall.physicsBody=SKPhysicsBody(rectangleOf: tempWall.size)
                tempWall.physicsBody!.categoryBitMask=BODYBITMASKS.WALL
                tempWall.physicsBody!.affectedByGravity=false
                tempWall.physicsBody!.isDynamic=false
                tempWall.physicsBody!.usesPreciseCollisionDetection=true
                tempWall.physicsBody!.collisionBitMask=BODYBITMASKS.ENEMY
                tempWall.name="wall"
                addChild(tempWall)
            } // for
        } // if in spawnwall state
        else if gameState==STATES.SPAWNVERTWALL
        {
            for x in 0..<10
            {
                let tempWall=SKSpriteNode(imageNamed: "wall00")
                tempWall.setScale(3.0)
                tempWall.position.x=pos.x
                tempWall.position.y = pos.y + (CGFloat(x)*tempWall.size.height)
                tempWall.zPosition=10
                tempWall.physicsBody=SKPhysicsBody(rectangleOf: tempWall.size)
                tempWall.physicsBody!.categoryBitMask=BODYBITMASKS.WALL
                tempWall.physicsBody!.affectedByGravity=false
                tempWall.physicsBody!.isDynamic=false
                tempWall.physicsBody!.usesPreciseCollisionDetection=true
                
                tempWall.physicsBody!.collisionBitMask=BODYBITMASKS.ENEMY
                tempWall.name="wall"
                addChild(tempWall)
            } // for
        } // if in spawn vert wall mode
        else if gameState==STATES.SPAWNENT
        {
            let tempEnt=EntityClass(theScene: self, id: entCount)
            tempEnt.game=game
            tempEnt.bodySprite.position=pos
            game.entList.append(tempEnt)
            entCount+=1
        } // if in spawn entity state
    } // touchDown()
    
    
    func touchMoved(toPoint pos : CGPoint) {
        if gameState==STATES.FIGHT
        {
            let dx=pos.x-pBody.position.x
            let dy=pos.y-pBody.position.y
            let angle=atan2(dy,dx)
            pBody.zRotation=angle
            // player.moveToPoint=pos
            // player.isMovingToPoint=true
        } // if in play state
    } // touchMoved()
    
    func touchUp(atPoint pos : CGPoint) {
        mousePressed=false
        
    } // touchUp()
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    } // mouseDown()
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    } // mouseDragged()
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    } // mouseUp()
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {

        case 0: // a
            leftPressed=true
            
        case 2: // d
            rightPressed=true
            
        case 1: // s
            downPressed=true
            
        case 13: // w
            upPressed=true
            
        case 14: // e
            attack()
            
        case 18: // 1
            if player.playerTalents[1].getCooldown() < 0
            {
            player.activeTalents.append(player.playerTalents[1])
                player.playerTalents[1].doTalent()
            }
            else
            {
                print("Dash on cooldown.")
            }
            
            
            
        case 27: // -
            zoomOutPressed=true
            
        case 24: // +
            zoomInPressed=true
            
            
        case 31: // o
            gameState=STATES.SPAWNENT
            
        case 35: // P
            gameState=STATES.FIGHT
            
        case 33: // [
            gameState=STATES.SPAWNWALL
            
        case 30: // ]
            gameState=STATES.SPAWNVERTWALL
            
            
        case 42: // \ (backslash)
            for ent in game.entList
            {
                ent.die()
            }
            for node in self.children
            {
                if node.name != nil
                {
                    if node.name!.contains("wall")
                    {
                        node.removeFromParent()
                    }
                } // if not nil
            } // for each node
        
        case 44: // / (forward slash)
            for ent in game.entList
            {
                ent.die()
            }
            for node in self.children
            {
                if node.name != nil
                {
                    if node.name!.contains("dng") || node.name!.contains("wall")
                    {
                        node.removeFromParent()
                    }
                } // if not nil
            } // for each node
            MAPSIZE=Int(random(min:64, max: 96))
            
            tempMap=MapClass(width: MAPSIZE, height: MAPSIZE, theScene: self)
            NUMENEMIES=MAPSIZE*MAPSIZE/tempMap!.ENTSPAWNFACTOR
            player.playerSprite!.position.x = CGFloat(tempMap!.roomPoints[tempMap!.startRoomIndex].x)*tempMap!.TILESIZE - (CGFloat(tempMap!.mapWidth)*tempMap!.TILESIZE) / 2
            player.playerSprite!.position.y = CGFloat(tempMap!.roomPoints[tempMap!.startRoomIndex].y)*tempMap!.TILESIZE - (CGFloat(tempMap!.mapHeight)*tempMap!.TILESIZE)/2
            
            
            // create a bunch of temp entities
            for _ in 1...NUMENEMIES
            {
                spawnEnemy()
            } // for
        /* Temporarily removing spacebar lock
        case 49: // space - Attack lock
            game.player!.isInAttackMode=true
        */
            


        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        } // switch keyCode
    } // keyDown()
    
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
            case 0:
                leftPressed=false
                
            case 2:
                rightPressed=false
                
            case 1:
                downPressed=false
                
            case 13:
                upPressed=false
            case 27:
                zoomOutPressed=false
                
            case 24:
                zoomInPressed=false
            
            case 49: // space - Attack lock
                game.player!.isInAttackMode=false
        default:
            break
        } // switch keyCode
    } // keyUp()
    
    
    func keyMovement()
    {
        
        if leftPressed
        {
            player.playerSprite!.position.x -= player.moveSpeed
            //player.playerSprite!.zRotation = CGFloat.pi
        }
        if rightPressed
        {
            player.playerSprite!.position.x += player.moveSpeed
            //player.playerSprite!.zRotation = 0
            
        }
        if upPressed
        {
            player.playerSprite!.position.y += player.moveSpeed
            //player.playerSprite!.zRotation = CGFloat.pi/2
            
        }
        if downPressed
        {
            player.playerSprite!.position.y -= player.moveSpeed
            //player.playerSprite!.zRotation = 3*CGFloat.pi/2
            
        }
        
        if cam.xScale > 0.75 && zoomInPressed
        {
            cam.setScale(cam.xScale-0.01)
            myLight.falloff=cam.xScale
        }
        
        if cam.xScale < 1.5 && zoomOutPressed
        {
            cam.setScale(cam.xScale+0.01)
            myLight.falloff=cam.xScale
        }

        /* Temp removal of directional facing
        // handle orientation
        if leftPressed && upPressed && !player.isInAttackMode
        {
            player.playerSprite!.zRotation = 3*CGFloat.pi/4
        }
        if leftPressed && downPressed && !player.isInAttackMode
        {
            player.playerSprite!.zRotation = 5*CGFloat.pi/4
        }
        if rightPressed && upPressed && !player.isInAttackMode
        {
            player.playerSprite!.zRotation = 1*CGFloat.pi/4
        }
        if rightPressed && downPressed && !player.isInAttackMode
        {
            player.playerSprite!.zRotation = 7*CGFloat.pi/4
        }
        */
    } // keyMovement
    
    func updateUI()
    {
        switch gameState
        {
        case STATES.FIGHT:
            stateLabel.text="Play State"
            
        case STATES.SPAWNWALL:
            stateLabel.text="Spawn Horz Wall State"
        case STATES.SPAWNVERTWALL:
            stateLabel.text="Spawn Vert Wall State"
        case STATES.SPAWNENT:
            stateLabel.text="Spawn Ent State"
        default:
            stateLabel.text="Error in State"
        } // switch gameState
        
        entCountLabel.text="\(game.entList.count)"
        
    } // updateUI()
    
    func cleanLists()
    {
        for i in 0..<game.entList.count
        {
            if game.entList[i].isDead
            {
                game.entList.remove(at: i)
                break
            } // if ent is dead
        } // for each ent
    } // clean lists
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        updateUI()
        cleanLists()

        if gameState==STATES.FIGHT
        {
            // increase our update cycle
            updateCycle += 1
            if updateCycle >= MAXAICYCLES
            {
                updateCycle=0
            }
            

            keyMovement()
            
            cam.position=player.playerSprite!.position
            myLight.position=player.playerSprite!.position
            player.update()
            
            for ent in game.entList
            {
                ent.update(cycle: updateCycle)
            }
        } // if we're in fight state
        
        
        

        
    } // update()
    
    
    
} // class GameScene
