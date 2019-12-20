//
//  GameScene.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import SpriteKit
import GameplayKit




class GameScene: SKScene {
    
    // SK Nodes
    var cam=SKCameraNode()
    var pBody=SKSpriteNode(imageNamed: "body")
    var pHead=SKSpriteNode(imageNamed: "head")
    var pArms=SKSpriteNode(imageNamed: "arms")
    
    
    var updateCycle:Int=0
    var entCount:Int=0
    
    
    var stateLabel=SKLabelNode(fontNamed: "Chalkduster")
    var entCountLabel=SKLabelNode(fontNamed: "Arial")
    
    var entCountBG=SKShapeNode()
    
    var game=GameClass()


    var myEnt=EntityClass()
    
    
    // KB Bools
    var upPressed:Bool=false
    var leftPressed:Bool=false
    var rightPressed:Bool=false
    var downPressed:Bool=false
    var mousePressed:Bool=false
    var zoomOutPressed:Bool=false
    var zoomInPressed:Bool=false
    
    
    var gameState:Int=STATES.FIGHT
    
    
    // CONSTANTS
    let MOVESPEED:CGFloat=10
    let MAXAICYCLES:Int=4
    
    
    // Temp Variables
    //var tempEnt=EntityClass()
    var player=PlayerClass()
    
    var entList=[EntityClass]()
    
    
    override func didMove(to view: SKView) {
        
        addChild(cam)
        self.camera=cam

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
        
        
        game=GameClass(theScene: self)

            player=PlayerClass(theGame: game)
            print("Player Created")
        
        game.player=player
        
        gameState=STATES.FIGHT
        player.playerSprite=pBody
        drawGrid()
        
        addChild(pBody)
        pBody.addChild(pHead)
        pBody.addChild(pArms)
        pBody.zPosition=1
        pHead.zPosition=2
        pArms.zPosition=2
        
        // create player physics body
        pBody.physicsBody=SKPhysicsBody(circleOfRadius: pBody.size.width/2)
        pBody.physicsBody!.categoryBitMask=BODYBITMASKS.PLAYER
        pBody.physicsBody!.collisionBitMask=BODYBITMASKS.WALL
        pBody.physicsBody!.affectedByGravity=false
        
        
        
        // create a bunch of temp entities
        for i in 1...500
        {
            let tempEnt=EntityClass(theScene: self, id: entCount)
            tempEnt.game=game
            tempEnt.bodySprite.position.x=random(min: -size.width, max: size.width)
            tempEnt.bodySprite.position.y=random(min: -size.height, max: size.height)
            entList.append(tempEnt)
            entCount+=1
        } // for
        
        
    } // didMove()
    
    func attack()
    {
        let tempSplode=SKEmitterNode(fileNamed: "FireSplode.sks")
        tempSplode!.position=player.playerSprite!.position
        tempSplode!.zPosition=10
        tempSplode!.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),SKAction.removeFromParent()]))
        addChild(tempSplode!)
        for node in self.children
        {
            if node.name != nil
            {
                if node.name!.contains("ent")
                {
                    let dx=player.playerSprite!.position.x - node.position.x
                    let dy=player.playerSprite!.position.y - node.position.y
                    let dist = hypot(dy, dx)
                    if dist < 60
                    {
                        // find in entList
                        for ent in entList
                        {
                            if ent.bodySprite.name! == node.name!
                            {
                                ent.die()
                               
                            } // we found the entity, kill it
                        } // for each entity
                        //print(node.name!)
                    } // if in range
                } // if ent
            } // if name not nil
        } // for each node
    } // attack()

    
    func drawGrid()
    {
        let gridWidth:Int=32
        
        for y in 1...gridWidth
        {
            for x in 1...gridWidth
            {
                let tempGrid=SKSpriteNode(imageNamed: "bgGrid")
                tempGrid.position.x = CGFloat(x-gridWidth/2)*(tempGrid.size.width)
                tempGrid.position.y = CGFloat(y-gridWidth/2)*tempGrid.size.height
                tempGrid.zPosition=0
                tempGrid.name="tempGrid"
                addChild(tempGrid)
            } // for x
        } // for y
    } // drawGrid()
    
    func touchDown(atPoint pos : CGPoint) {
        
        if gameState==STATES.FIGHT
        {
            mousePressed=true
            let dx=pos.x-pBody.position.x
            let dy=pos.y-pBody.position.y
            let angle=atan2(dy,dx)
            pBody.zRotation=angle
            player.moveToPoint=pos
            player.isMovingToPoint=true
        } // if play state
        else if gameState==STATES.SPAWNWALL
        {
            for x in 1...10
            {
                let tempWall=SKSpriteNode(imageNamed: "wall00")
                tempWall.setScale(2.0)
                tempWall.position.y=pos.y
                tempWall.position.x = pos.x + (CGFloat(x)*tempWall.size.width)
                tempWall.zPosition=10
                tempWall.physicsBody=SKPhysicsBody(rectangleOf: tempWall.size)
                tempWall.physicsBody!.categoryBitMask=BODYBITMASKS.WALL
                tempWall.physicsBody!.affectedByGravity=false
                tempWall.physicsBody!.isDynamic=false
                tempWall.physicsBody!.collisionBitMask=BODYBITMASKS.ENEMY
                tempWall.name="wall"
                addChild(tempWall)
            } // for
        } // if in spawnwall state
        else if gameState==STATES.SPAWNVERTWALL
        {
            for x in 1...10
            {
                let tempWall=SKSpriteNode(imageNamed: "wall00")
                tempWall.setScale(2.0)
                tempWall.position.x=pos.x
                tempWall.position.y = pos.y + (CGFloat(x)*tempWall.size.height)
                tempWall.zPosition=10
                tempWall.physicsBody=SKPhysicsBody(rectangleOf: tempWall.size)
                tempWall.physicsBody!.categoryBitMask=BODYBITMASKS.WALL
                tempWall.physicsBody!.affectedByGravity=false
                tempWall.physicsBody!.isDynamic=false
                tempWall.physicsBody!.collisionBitMask=BODYBITMASKS.ENEMY
                tempWall.name="wall"
                addChild(tempWall)
            } // for
        }
        else if gameState==STATES.SPAWNENT
        {
            let tempEnt=EntityClass(theScene: self, id: entCount)
            tempEnt.game=game
            tempEnt.bodySprite.position=pos
            entList.append(tempEnt)
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
            player.moveToPoint=pos
            player.isMovingToPoint=true
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

        case 0:
            leftPressed=true
            
        case 2:
            rightPressed=true
            
        case 1:
            downPressed=true
            
        case 13:
            upPressed=true
            
        case 18: // 1
            attack()
            
        case 27:
            zoomOutPressed=true
            
        case 24:
            zoomInPressed=true
            
            
        case 31: // o
            gameState=STATES.SPAWNENT
            
        case 35: // P
            gameState=STATES.FIGHT
            
        case 33: // [
            gameState=STATES.SPAWNWALL
            
        case 30:
            gameState=STATES.SPAWNVERTWALL
            
            
        case 42: // \ (backslash)
            for ent in entList
            {
                ent.die()
            }
            
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
        default:
            break
        } // switch keyCode
    } // keyUp()
    
    
    func keyMovement()
    {
        if leftPressed
        {
            player.playerSprite!.position.x -= MOVESPEED
        }
        if rightPressed
        {
            player.playerSprite!.position.x += MOVESPEED
            
        }
        if upPressed
        {
            player.playerSprite!.position.y += MOVESPEED
            
        }
        if downPressed
        {
            player.playerSprite!.position.y -= MOVESPEED
            
        }
        
        if cam.xScale > 0.01 && zoomInPressed
        {
            cam.setScale(cam.xScale-0.01)
        }
        
        if cam.xScale < 4.0 && zoomOutPressed
        {
            cam.setScale(cam.xScale+0.01)
        }

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
        
        entCountLabel.text="\(entList.count)"
        
    } // updateUI()
    
    func cleanLists()
    {
        for i in 0..<entList.count
        {
            if entList[i].isDead
            {
                entList.remove(at: i)
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
            
            if !mousePressed
            {
                keyMovement()
            }
            cam.position=player.playerSprite!.position
            
            player.update()
            
            for ent in entList
            {
                ent.update(cycle: updateCycle)
            }
        } // if we're in fight state
        
        
        

        
    } // update()
    
    
    
} // class GameScene
