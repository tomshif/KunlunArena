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
        
        // create a bunch of temp entities
        for i in 1...500
        {
            let tempEnt=EntityClass(theScene: self, id: i)
            tempEnt.game=game
            tempEnt.bodySprite.position.x=random(min: -size.width, max: size.width)
            tempEnt.bodySprite.position.y=random(min: -size.height, max: size.height)
            entList.append(tempEnt)
        } // for
        
        
    } // didMove()
    
    func attack()
    {
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
        mousePressed=true
        let dx=pos.x-pBody.position.x
        let dy=pos.y-pBody.position.y
        let angle=atan2(dy,dx)
        pBody.zRotation=angle
    
    } // touchDown()
    
    
    func touchMoved(toPoint pos : CGPoint) {
        let dx=pos.x-pBody.position.x
        let dy=pos.y-pBody.position.y
        let angle=atan2(dy,dx)
        pBody.zRotation=angle
    } // touchMoved()
    
    func touchUp(atPoint pos : CGPoint) {
        mousePressed=false
        attack()
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
        case 27:
            zoomOutPressed=true
            
        case 24:
            zoomInPressed=true
            
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
            cam.position.x -= MOVESPEED
        }
        if rightPressed
        {
            cam.position.x += MOVESPEED
            
        }
        if upPressed
        {
            cam.position.y += MOVESPEED
            
        }
        if downPressed
        {
            cam.position.y -= MOVESPEED
            
        }
        
        if cam.xScale > 0.01 && zoomInPressed
        {
            cam.setScale(cam.xScale-0.01)
        }
        
        if cam.xScale < 4.0 && zoomOutPressed
        {
            cam.setScale(cam.xScale+0.01)
        }
        
        /*
        if !mousePressed
        {
            if rightPressed
            {
                pBody.zRotation=0
            }
            if leftPressed
            {
                pBody.zRotation=CGFloat.pi
            }
            if upPressed
            {
                pBody.zRotation=CGFloat.pi/2
            }
            if downPressed
            {
                pBody.zRotation=3*CGFloat.pi/2
            }
            if rightPressed && upPressed
            {
                pBody.zRotation=CGFloat.pi/4
            }
            if leftPressed && upPressed
            {
                pBody.zRotation = 3*CGFloat.pi/4
            }
            
            if leftPressed && downPressed
            {
                pBody.zRotation = 5*CGFloat.pi/4
            }
            
            if rightPressed && downPressed
            {
                pBody.zRotation = 7*CGFloat.pi/4
            }
        }
         */
    } // keyMovement
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        // increase our update cycle

        
        
        if gameState==STATES.FIGHT
        {
            updateCycle += 1
            if updateCycle >= MAXAICYCLES
            {
                updateCycle=0
            }
            keyMovement()
            pBody.position=cam.position
            for ent in entList
            {
                ent.update(cycle: updateCycle)
            }
        } // if we're in fight state
        
        
        

        
    } // update()
    
    
    
} // class GameScene
