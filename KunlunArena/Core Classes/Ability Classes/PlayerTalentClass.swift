//
//  PlayerTalentClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/10/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This is the base class for all player talents and abilities, from the simplest melee attack to the most complicated special move.
//
// Subclasses of this class should be completely self-contained, meaning that they will perform all checks for what entities are hit by attacks, modify player attributes, create and remove child nodes for special effects, etc.
//
// Only the init(), getCoolDown(), updateTalent() and the doTalent() functions should be exposed, all others should be internal or private.
//
// doTalent() should contain all code necessary to carry out the talent.
//
// PlayerClass will handle checking the active talents and removing active talents that need to be removed.


import Foundation
import SpriteKit

class PlayerTalentClass
{
    var game:GameClass?
    var name:String="Talent"
    var isAction:Bool=false
    var tier:Int=0
    var lastUse=NSDate()
    var lengthActive:Double=0
    var COOLDOWN:Double=1.5
    var isActive:Bool=false
    
    
    
    init(theGame: GameClass)
    {
        game=theGame
        
    } // init game
    
    public func getCooldown() -> Double
    {
        let timeSinceLastUse = -lastUse.timeIntervalSinceNow

        return COOLDOWN-timeSinceLastUse
    } //  getCooldown()
    
    public func activeLengthLeft() -> Double
    {
        let timeActive = -lastUse.timeIntervalSinceNow
        
        return lengthActive-timeActive
        
    }
    
    public func updateTalent()
    {
        
    } // updateTalent()
    
    public func removeTalent()
    {
        
    } // removeTalent()
    
    public func doTalent()
    {
        
    } // doTalent()
    
    
} // PlayerTalentClass
