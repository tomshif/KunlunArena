//
//  FIreBreathTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 1/29/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//
// This class is intended only as an example of one way that a PTC could be implemented to do an AoE attack in a "cone" in front of the player.
// This system doesn't use an actual cone shape, but instead picks a point in front of the player's direction and then checks all entities to see if they are in a certain radius of that point.



import Foundation
import SpriteKit

class FireBreathTalentClass:PlayerTalentClass
{
    var oldMovementSpeed:CGFloat=0
    
    override init(theGame: GameClass)
    {
        // This is the only initializer that will ever be used. We will always pass the class when initializing talents
        super.init(theGame: theGame)
        name="Fire Breath"
        description="Breaths a column of fire in front of the player, burning all enemies for 300% weapon damage."
        isAction=false
        game=theGame
        COOLDOWN=10
        lengthActive=1.5
        manaCost=20
        iconName="fireBreathTalentIcon"
    } // init game
    
    
    override func doTalent()
    {
        oldMovementSpeed=game!.player!.moveSpeed
        game!.player!.moveSpeed=0
        
        lastUse=NSDate()
        isActive=true
        
        print("Fire Breath")
        let fireNode=SKEmitterNode(fileNamed: "FireBreathTalentEmitter.sks")
        fireNode!.position=game!.player!.playerSprite!.position
        fireNode!.zPosition=game!.player!.playerSprite!.zPosition-0.00001
        fireNode!.zRotation=game!.player!.playerSprite!.zRotation
        
        fireNode!.run(SKAction.sequence([SKAction.wait(forDuration: 1.5),SKAction.removeFromParent()]))
        fireNode!.setScale(1.3)
        game!.scene!.addChild(fireNode!)
        
 
        
    } // doTalent()
    override func updateTalent()
    {
        game!.player!.mana -= manaCost/2/4
        // check for enemies hit
         
         // determine dx/dy to center of hit area
         let dx=cos(game!.player!.playerSprite!.zRotation)*100+game!.player!.playerSprite!.position.x
         let dy=sin(game!.player!.playerSprite!.zRotation)*100+game!.player!.playerSprite!.position.y
         
         // check for all enemies within 100 pixels of this spot
         for ent in game!.entList
         {
             // compute distance of ent from center of area
             let entdx=dx-ent.bodySprite.position.x
             let entdy=dy-ent.bodySprite.position.y
             let dist=hypot(entdy,entdx)

             if dist < 100
             {
                 ent.takeDamage(amount: game!.player!.equippedWeapon!.iLevelMod * game!.player!.equippedWeapon!.modLevel*3/4/2)
                 
             } // if in range do damage
         } // for each ent
         
        
    } // update talent
    override func removeTalent()
    {
        game!.player!.moveSpeed=oldMovementSpeed
        isActive=false
    } // removeTalent()
    
} // FireBreathTalentClass
