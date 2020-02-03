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
    var pBody=SKSpriteNode()
    var pHead=SKSpriteNode(imageNamed: "head")
    var pArms=SKSpriteNode(imageNamed: "arms")

    // UI
    var itemScreen=SKSpriteNode(imageNamed: "itemScrollBG")

    var stateLabel=SKLabelNode(fontNamed: "Chalkduster")
    var entCountLabel=SKLabelNode(fontNamed: "Arial")
    var copyrightLabel=SKLabelNode(text: "(C) LCS Game Design, 2020.")
    var buildLabel=SKLabelNode(fontNamed: "Arial")
    var pHealthLabel=SKLabelNode(fontNamed: "Chalkduster")
    var pManaLabel=SKLabelNode(fontNamed: "Chalkduster")
    var hudBar=SKSpriteNode(imageNamed: "hud01")
    var hudMana=SKSpriteNode(imageNamed: "hudMana")
    var hudHealth=SKSpriteNode(imageNamed: "hudHealth")
    
    
    var actionBarFrame=SKSpriteNode(imageNamed: "actionBarFrame")
    
    var actionCoolDowns=[SKSpriteNode]()
    
    
    var entCountBG=SKShapeNode()
    
    var bgParticle=SKEmitterNode() // This looks crappy, needs to be different
    
    var myLight=SKLightNode()

    
      
    
    // Ints
    var updateCycle:Int=0 // Moderates AI updates for performance
    var talentUpdateCycle:Int=0 // Moderates talent updates for performance
    var entCount:Int=0
    var gameState:Int=STATES.FIGHT
    var MAPSIZE:Int=90
    
    // Core Classes
    var game=GameClass()
    var toolTips:ToolTipClass?
    
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
        
         ///////////////////////////////////////
         // Init the game

        ///////////////////////////////////////


        let trackingArea=NSTrackingArea(rect: view.frame, options: NSTrackingArea.Options(rawValue: UInt(UInt8(NSTrackingArea.Options.activeInKeyWindow.rawValue) | UInt8(NSTrackingArea.Options.mouseMoved.rawValue))), owner: self, userInfo: nil)
        view.addTrackingArea(trackingArea)
        
         game=GameClass(theScene: self)
         initInventory(game: game)
         player=PlayerClass(theGame: game)
         game.player=player
         game.player!.equipRefresh()
         gameState=STATES.FIGHT
        toolTips=ToolTipClass(theGame: game)
        game.cam=cam
        

        
        
         player.playerSprite=SKSpriteNode(imageNamed: "body")
        addChild(player.playerSprite!)
        pBody=player.playerSprite!
        
        
        MAPSIZE=Int(random(min:64, max: 96))
        
        //addChild(myLight)
        myLight.falloff=1
        
        // Init Camera and BG
        addChild(cam)
        self.camera=cam
        self.backgroundColor=NSColor.black
        
        // Gen Map
        tempMap=MapClass(width: MAPSIZE, height: MAPSIZE, theScene: self, theGame:game)
        
        
        NUMENEMIES=MAPSIZE*MAPSIZE/tempMap!.ENTSPAWNFACTOR
        
        game.map=tempMap
        
        // Setup Labels
        copyrightLabel.position.y = -size.height*0.475
        copyrightLabel.position.x = -size.width*0.385
        copyrightLabel.fontName="Arial"
        copyrightLabel.fontSize=16
        copyrightLabel.fontColor=NSColor.red
        cam.addChild(copyrightLabel)
        copyrightLabel.zPosition=20000
        
        buildLabel.position.x = size.width*0.4
        buildLabel.position.y = -size.height*0.45
        buildLabel.zPosition = 20000
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
        
        pHealthLabel.fontSize=40
        pHealthLabel.position=CGPoint(x: -size.width*0.35, y: -size.height*0.245)
        pHealthLabel.text="Health"
        pHealthLabel.zPosition=10000
        pHealthLabel.fontColor=NSColor.red
        cam.addChild(pHealthLabel)
        
        pManaLabel.fontSize=40
        pManaLabel.position=CGPoint(x: size.width*0.35, y: -size.height*0.245)
        pManaLabel.text="Mana"
        pManaLabel.fontColor=NSColor.blue
        pManaLabel.zPosition=10000
        cam.addChild(pManaLabel)
        
        bgParticle=SKEmitterNode(fileNamed: "SmokeBG.sks")!
        addChild(bgParticle)
        bgParticle.setScale(4.0)
        
        actionBarFrame.position.y = -size.height*0.4
        actionBarFrame.zPosition=10000
        cam.addChild(actionBarFrame)
        updateActionBar()
        
        hudBar.zPosition=9500
        hudBar.position.y = -size.height*0.35
        hudBar.setScale(1.25)
        cam.addChild(hudBar)
        
        hudMana.zPosition=9450
        hudMana.position.y = -size.height*0.35
        hudMana.position.x = size.width*0.35
        hudMana.setScale(1.25)
        cam.addChild(hudMana)
        
        hudHealth.zPosition=9450
        hudHealth.position.y = -size.height*0.35
        hudHealth.position.x = -size.width*0.35
        hudHealth.setScale(1.25)
        cam.addChild(hudHealth)

        
        
        
        // Setup the player sprite (needs to be moved to PlayerClass init)
        
        
        pBody.addChild(pHead)
        pBody.addChild(pArms)
        pBody.zPosition=100
        pHead.zPosition=115
        pArms.zPosition=115
        pBody.name="playerSprite"
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
        
        
        // Initializer UI Elements
        
        // Item Window
        itemScreen.isHidden=true
        itemScreen.zPosition=10000
        cam.addChild(itemScreen)
        
        
    } // didMove()
    
    func spawnEnemy()
    {

        let tempEntHorse=HorseEntClass(theGame: game, id: entCount)

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

        tempEntHorse.bodySprite.position.x=xp
        tempEntHorse.bodySprite.position.y=yp
        game.entList.append(tempEntHorse)
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

    func updateItemScreen()
    {
        itemScreen.removeAllChildren()
        let itemNameLabel=SKLabelNode(fontNamed: "Tahoma")
        itemNameLabel.position.y=itemScreen.size.height*0.30
        itemNameLabel.fontColor=game.player!.equippedWeapon!.itemLevelColor
        itemNameLabel.text=game.player!.equippedWeapon!.name
        itemScreen.addChild(itemNameLabel)
        itemNameLabel.zPosition=10010

        let itemLevelLabel=SKLabelNode(fontNamed: "Tahoma")
        itemLevelLabel.position.y=itemScreen.size.height*0.25
        itemLevelLabel.color=NSColor.white
        itemLevelLabel.fontSize=24
        itemLevelLabel.zPosition=10010
        itemLevelLabel.text="Item Level: \(game.player!.equippedWeapon!.iLevel)"
        itemScreen.addChild(itemLevelLabel)
    
        let itemDamageLabel=SKLabelNode(fontNamed: "Tahoma")
        itemDamageLabel.position.y=itemScreen.size.height*0.20
        itemDamageLabel.color=NSColor.white
        itemDamageLabel.fontSize=24
        itemDamageLabel.zPosition=10010
        itemDamageLabel.text=String(format: "Damage: %2.2f", game.player!.equippedWeapon!.modLevel*game.player!.equippedWeapon!.iLevelMod)
        itemScreen.addChild(itemDamageLabel)
        
        let itemSpeedLabel=SKLabelNode(fontNamed: "Tahoma")
        itemSpeedLabel.position.y=itemScreen.size.height*0.15
        itemSpeedLabel.color=NSColor.white
        itemSpeedLabel.fontSize=24
        itemSpeedLabel.zPosition=10010
        itemSpeedLabel.text=String(format: "Speed: %1.2f", game.player!.equippedWeapon!.attackSpeedFactor)
        itemScreen.addChild(itemSpeedLabel)
        
        
        let itemMod1=SKLabelNode(fontNamed: "Tahoma")
        itemMod1.position.y=itemScreen.size.height*0.05
        itemMod1.color=NSColor.white
        itemMod1.fontSize=24
        itemMod1.zPosition=10010
        itemMod1.text=String(format: "\(game.player!.equippedWeapon!.getFirstEffectString()) +%1.2f", game.player!.equippedWeapon!.statsMod)
        itemScreen.addChild(itemMod1)
        
        let itemMod2=SKLabelNode(fontNamed: "Tahoma")
        itemMod2.position.y=itemScreen.size.height*0.00
        itemMod2.color=NSColor.white
        itemMod2.fontSize=24
        itemMod2.zPosition=10010
        itemMod2.text=String(format: "\(game.player!.equippedWeapon!.getSecondEffectString()) +%1.2f", game.player!.equippedWeapon!.statsMod)
        itemScreen.addChild(itemMod2)
        
    } // updateItemScreen
    
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
            // First we check to see if we clicked on loot
            for node in self.nodes(at: pos)
            {
                if node.name != nil
                {
                    if node.name!.contains("loot") && !node.hasActions()
                    {
                        // first, drop the loot we have
                        game.player!.dropLoot(loot: game.player!.equippedWeapon!)
                        
                        let last5 = Int(node.name!.suffix(5))
                        
                        print("Last 5: \(last5!)")
                        print("Loot: \(game.lootList[last5!].name)")
                        
                        // pick up the loot
                        game.player!.equippedWeapon=game.lootList[last5!]
                        game.player!.resetStats()
                        game.player!.equipRefresh()
                        // remove the sprite
                        node.removeFromParent()
                        
                    } // if it's loot
                    
                } // if name not nil
                
            } // for each node
            
            
            // click to attack
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
            let tempEnt=EntityClass(theGame: game, id: entCount)
            tempEnt.game=game
            tempEnt.bodySprite.position=pos
            game.entList.append(tempEnt)
            entCount+=1
        } // if in spawn entity state
    } // touchDown()
    
    
    func updateActionBar()
    {
        for i in 1...8
        {
            let tempAction=SKSpriteNode(imageNamed: "actionFrame")
            tempAction.name="actButton0\(i)"
            tempAction.position.x = -size.width*0.27 + (tempAction.size.width*1.08*CGFloat(i))
            //tempAction.position.y = size.height*0.4
            tempAction.zPosition=10010
            actionBarFrame.addChild(tempAction)
            
            let buttonLabel=SKLabelNode(fontNamed: "Arial")
            buttonLabel.fontSize=12
            buttonLabel.position.x = -tempAction.size.width*0.4
            buttonLabel.position.y = -tempAction.size.height*0.4
            buttonLabel.text="\(i)"
            buttonLabel.zPosition=tempAction.zPosition+1
            buttonLabel.name="actButtonLabel0\(i)"
            tempAction.addChild(buttonLabel)
            
            // draw icons
            if i < player.playerTalents.count
            {
                print("crashing on \(i)")
                print("talent name: \(player.playerTalents[i].name)")
                let tempIcon=SKSpriteNode(imageNamed: player.playerTalents[i].iconName)
                tempIcon.zPosition=tempAction.zPosition+1
                
                tempAction.addChild(tempIcon)
            } // if we have a talent in this slot
            
            // setup cooldowns
            let tempActionCD=SKSpriteNode(imageNamed: "actionCooldown")
            tempActionCD.zPosition=tempAction.zPosition+5
            tempActionCD.name="actCooldown0\(i)"
            tempAction.addChild(tempActionCD)
            actionCoolDowns.append(tempActionCD)
            
        } // for each button
    } // updateActionsBar
    
    
    func updateCooldowns()
    {
        if actionCoolDowns.count > 0
        {
            for i in 1..<player.playerTalents.count
            {
                // get the cooldown remaing %
                if player.playerTalents[i].getCooldown() > 0
                {
                    actionCoolDowns[i-1].isHidden=false
                    actionCoolDowns[i-1].yScale=player.playerTalents[i].getCooldownRatio()
                    actionCoolDowns[i-1].position.y = -32*(1-player.playerTalents[i].getCooldownRatio())
                } // if on cooldown
                else
                {
                    actionCoolDowns[i-1].isHidden=true
                    
                } // else
            } // for each action cooldown sprite
        } // if we have action cooldown sprites in our list
        
    } // updateCooldowns()
    
    
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
    
    override func mouseMoved(with event: NSEvent) {
        // turn player to face cursor
        
        let dx=event.location(in: self).x - game.player!.playerSprite!.position.x
        let dy=event.location(in: self).y-game.player!.playerSprite!.position.y
        
        let angle=atan2(dy, dx)
        game.player!.playerSprite!.zRotation=angle
        
        
        // update tooltip if active
        if toolTips!.active
        {
            toolTips!.updateToolTip(loc: event.location(in: self))
        }
        
        
        
        // check for mouse over a dropped item
        for node in self.nodes(at: event.location(in: self))
        {
            if node.name != nil
            {
                if node.name!.contains("loot")
                {
                    if !toolTips!.active
                    {
                        // get the number from the loot
                        let cutString=node.name!.suffix(5)
                        let lootNum=Int(cutString)
                        toolTips!.createLoot(num: lootNum!, loc: event.location(in: self))
                        
                        print("loot m/o: \(lootNum)")
                    } // if we don't have an active toolTip
                } // if it's loot
                else
                {
                    if toolTips!.active && toolTips!.loot >= 0
                    {
                        toolTips!.removeToolTip()
                    } // if we have an active loot tooltip
                } // if we're not mousing over loot
            } // if name not nil
            
        } // for each node at the spot
        
    } // mouseMoved()
    
    
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
            if player.playerTalents[TalentList.dash].getCooldown() < 0 && player.mana >= player.playerTalents[TalentList.dash].manaCost
            {
            player.activeTalents.append(player.playerTalents[TalentList.dash])
                player.playerTalents[TalentList.dash].doTalent()
            }
            else
            {
                print("Dash on cooldown or not enough mana.")
            }
            
        case 19: // 2
            if player.playerTalents[TalentList.swordOfLightning].getCooldown() < 0 && player.mana >= player.playerTalents[TalentList.swordOfLightning].manaCost
                     {
                     player.activeTalents.append(player.playerTalents[TalentList.swordOfLightning])
                         player.playerTalents[TalentList.swordOfLightning].doTalent()
                     }
                     else
                     {
                         print("Sword of Lightning on cooldown or OOM.")
                     }
            
        case 20: // 3
            if player.playerTalents[TalentList.fireBreath].getCooldown() < 0 && player.mana >= player.playerTalents[TalentList.fireBreath].manaCost
                     {
                     player.activeTalents.append(player.playerTalents[TalentList.fireBreath])
                         player.playerTalents[TalentList.fireBreath].doTalent()
                     }
                     else
                     {
                         print("Fire Breath on cooldown.")
                     }
        case 21: // 4
            if player.playerTalents[TalentList.ghostDodge].getCooldown() < 0 && player.mana >= player.playerTalents[TalentList.ghostDodge].manaCost
                     {
                     player.activeTalents.append(player.playerTalents[TalentList.ghostDodge])
                         player.playerTalents[TalentList.ghostDodge].doTalent()
                     }
                     else
                     {
                         print("Ghost Dodge on cooldown.")
                     }
            
            
        case 23: // 5
            if player.playerTalents[TalentList.cherryBomb].getCooldown() < 0 && player.mana >= player.playerTalents[TalentList.cherryBomb].manaCost
                     {
                     player.activeTalents.append(player.playerTalents[TalentList.cherryBomb])
                         player.playerTalents[TalentList.cherryBomb].doTalent()
                     }
                     else
                     {
                         print("Cherry Bomb on cooldown.")
                     }
        case 27: // -
            zoomOutPressed=true
            
        case 24: // +
            zoomInPressed=true
            
        case 29: // 0 -- generate new weapon
            if gameState==STATES.ITEM
            {
            game.player!.equippedWeapon=BaseInventoryClass(game: game)
                game.player!.resetStats()
                game.player!.equipRefresh()
                updateItemScreen()
            }
            
        case 31: // o
            gameState=STATES.SPAWNENT
            
        case 35: // P
            gameState=STATES.FIGHT
            
        case 33: // [
            gameState=STATES.SPAWNWALL
            
        case 30: // ]
            gameState=STATES.SPAWNVERTWALL
            
            
        case 34: // I
            if (gameState==STATES.ITEM)
            {
                gameState=STATES.FIGHT
            }
            else
            {
                gameState=STATES.ITEM
                updateItemScreen()
            }
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
                ent.remove()
            }
            
            
            
            for node in self.children
            {
                if node.name != nil
                {
                    if node.name!.contains("dng") || node.name!.contains("wall") || node.name!.contains("loot")
                    {
                        node.removeFromParent()
                    }
                } // if not nil
            } // for each node
            MAPSIZE=Int(random(min:64, max: 96))
            game.map!.miniMap!.removeAllChildren()
            
            tempMap=MapClass(width: MAPSIZE, height: MAPSIZE, theScene: self, theGame:game)
            NUMENEMIES=MAPSIZE*MAPSIZE/tempMap!.ENTSPAWNFACTOR
            game.lootList.removeAll()
            game.lootCounter=0
            player.playerSprite!.position.x = CGFloat(tempMap!.roomPoints[tempMap!.startRoomIndex].x)*tempMap!.TILESIZE - (CGFloat(tempMap!.mapWidth)*tempMap!.TILESIZE) / 2
            player.playerSprite!.position.y = CGFloat(tempMap!.roomPoints[tempMap!.startRoomIndex].y)*tempMap!.TILESIZE - (CGFloat(tempMap!.mapHeight)*tempMap!.TILESIZE)/2
            
            
            // create a bunch of temp entities
            for _ in 1...NUMENEMIES
            {
                spawnEnemy()
            } // for
            
            game.map=tempMap
            
            
        /* Temporarily removing spacebar lock
        case 49: // space - Attack lock
            game.player!.isInAttackMode=true
        */
            
        case 46:
            game.map!.miniMap!.isHidden.toggle()



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
        updateCooldowns()
        
        // update player position on minimap
        game.map!.playerArrow.position.x = game.player!.playerSprite!.position.x / 6 * 0.15
        game.map!.playerArrow.position.y = game.player!.playerSprite!.position.y / 6 * 0.15
        game.map!.playerArrow.zRotation=game.player!.playerSprite!.zRotation
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
        case STATES.ITEM:
            stateLabel.text="Item Test State"
        default:
            stateLabel.text="Error in State"
        } // switch gameState
        
        entCountLabel.text="\(game.entList.count)"
        pHealthLabel.text=String(format: "%2.0f / %2.0f",player.health, player.maxHealth)
        pManaLabel.text=String(format: "%2.0f / %2.0f",player.mana, player.maxMana)
        
        // update health and mana balls
        hudMana.yScale = player.mana/player.maxMana
        hudMana.position.y = -size.height*0.47 - (1-(175/2*game.player!.mana/game.player!.maxMana))
        
        hudHealth.yScale = player.health/player.maxHealth
        hudHealth.position.y = -size.height*0.47 - (1-(175/2*game.player!.health/game.player!.maxHealth))
        
        
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
        
        if gameState != STATES.ITEM
        {
            itemScreen.isHidden=true
        }
        if gameState==STATES.FIGHT
        {
            
            
            // increase our update cycle
            updateCycle += 1
            if updateCycle >= MAXAICYCLES
            {
                updateCycle=0
            }
            talentUpdateCycle += 1
            if talentUpdateCycle >= 15
            {
                talentUpdateCycle = 0
            }

            keyMovement()
            
            cam.position=player.playerSprite!.position
            myLight.position=player.playerSprite!.position
            player.update()
            // update player talents
            if (talentUpdateCycle==0)
            {
                player.updateTalents()
            } 
            
            for ent in game.entList
            {
                ent.update(cycle: updateCycle)
            }
        } // if we're in fight state
        else
        {
            itemScreen.isHidden=false
        }
        
        
        

        
    } // update()
    
    
    
} // class GameScene
