//
//  EnemySkillClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/10/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
// This class will serve as the base class for all enemy talents/abilities/skills/attacks/etc.
// Anything other than move that enemies do should be contained in a child class of this class.
// It will work very similar to the PlayerTalentClasses where entities will have an array of known skills and then choose (intelligently) from that list based on a prioritized list, cooldowns and situations.
// Entities will also have a list of active skills, similiar to the PlayerClass, but unlike the PlayerClass, active skills will be removed by the entity intead of the GameScene.


import Foundation
import SpriteKit

class EnemySkillClass
{
    var scene:GameScene?
    var isAction:Bool=false
    var tier:Int=0
    var lastUse=NSDate()
    var lengthActive:Double=0
    var COOLDOWN:Double=1.5
    var isActive:Bool=false
    var manaCost:CGFloat=10.00
    
    var entity:EntityClass?
    
    init(theScene: GameScene, ent: EntityClass)
    {
        scene=theScene
        entity=ent
    } // init(scene)
    
    public func doSkill()
    {
        
    }
    
    public func updateSkill()
    {
        
    }
    
    public func removeSkill()
    {
        
    }
    
    
    
} // class EnemySkillClass
