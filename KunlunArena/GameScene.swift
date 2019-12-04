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
    
    
    var game:GameClass?
    var player:PlayerClass?

    var myEnt=EntityClass()
    
    
    // KB Bools
    var upPressed:Bool=false
    var leftPressed:Bool=false
    var rightPressed:Bool=false
    var downPressed:Bool=false
    
    
    var gameState:Int=STATES.FIGHT
    
    
    // CONSTANTS
    let MOVESPEED:CGFloat=10
    
    
    
    override func didMove(to view: SKView) {
        
        addChild(cam)
        self.camera=cam
        
        game=GameClass(theScene: self)
        if game != nil
        {
            player=PlayerClass(theGame: game!)
        }
        
        
        gameState=STATES.FIGHT
        
        drawGrid()
        
    } // didMove()
    
    
    func touchDown(atPoint pos : CGPoint) {

    } // touchDown()
    
    
    func drawGrid()
    {
        let gridWidth:Int=64
        
        for y in 1...gridWidth
        {
            for x in 1...gridWidth
            {
                let tempGrid=SKSpriteNode(imageNamed: "bgGrid")
                tempGrid.position.x = CGFloat(x-32)*(tempGrid.size.width)
                tempGrid.position.y = CGFloat(y-32)*tempGrid.size.height
                tempGrid.zPosition=0
                tempGrid.name="tempGrid"
                addChild(tempGrid)
            } // for x
        } // for y
    } // drawGrid()
    
    func touchMoved(toPoint pos : CGPoint) {

    } // touchMoved()
    
    func touchUp(atPoint pos : CGPoint) {

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
    } // keyMovement
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if gameState==STATES.FIGHT
        {
            keyMovement()
        }
    } // update()
    
    
    
} // class GameScene
