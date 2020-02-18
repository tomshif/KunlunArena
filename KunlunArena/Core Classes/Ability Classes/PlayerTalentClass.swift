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
    var description:String="Description"
    var isAction:Bool=false
    var tier:Int=0
    var lastUse=NSDate()
    var lengthActive:Double=0
    var COOLDOWN:Double=1.5
    var isActive:Bool=false
    var manaCost:CGFloat=10.00
    var iconName:String=""
    
    init(theGame: GameClass)
    {
        // The initializer will always pass the game so that we have access to the scene, player and entList
        
        game=theGame
        iconName="dashTalentIcon"
        
        
    } // init game
    
    public func getCooldown() -> Double
    {
        // Returns the time left until the cooldown is ready when positive
        // If the value is negative, then the talent is off cooldown.
        //
        let timeSinceLastUse = -lastUse.timeIntervalSinceNow

        return COOLDOWN-timeSinceLastUse
    } //  getCooldown()
    
    public func getCooldownRatio()->CGFloat
    {
        let time=getCooldown()
        let ratio=CGFloat(time/self.COOLDOWN)
        return ratio
    }
    
    public func activeLengthLeft() -> Double
    {
        // Returns how much time is left before the talent expires (when positive)
        // If the value is negative, then the talent has already expired
        
        let timeActive = -lastUse.timeIntervalSinceNow
        
        return lengthActive-timeActive
        
    } // activeLengthLeft()
    
    public func updateTalent()
    {
        // This method is called each frame while the method is active
        // If the talent is a one shot thing, this method won't need to do anything.
        // Note that this will always be called from the GameScene and should not be called internally.
        
    } // updateTalent()
    
    public func removeTalent()
    {
        // This talent will be called when the talent expires.
        // Note that this will always be called from the GameScene and should not be called internally.
        
        
        
    } // removeTalent()
    
    public func doTalent()
    {
        // This method will be called when the talent is first begun.
        // For one shot talents, this will handle everything all in one
        // Note that this will always be called from the GameScene and should not be called internally.
        
        
        // Update Global Cooldown
        game!.player!.lastAction=NSDate()
        
    } // doTalent()
    
    
} // PlayerTalentClass
// 
