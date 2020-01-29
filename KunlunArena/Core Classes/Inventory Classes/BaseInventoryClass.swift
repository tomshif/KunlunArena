//
//  BaseInventoryClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/4/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//
//
// This class will be the base class for the different inventory types. It won't be sub classed, but instanced out to represent different weapons.

import Foundation
import SpriteKit

class BaseInventoryClass
{
    var name:String=""
    var iLevel:Int=0
    var iLevelMod:CGFloat=0
    var statsMod:CGFloat=0
    
    var invType:Int=0
    var talentType:Int=0
    
    var rarity:Int=0
    
    var prefixNum:Int=0
    var suffixNum:Int=0
    var invSlot:Int=0

    var modLevel:CGFloat=0
    
    var attackSpeedFactor:CGFloat=0
    var effects:Int=0
    let BASEEFFECTSMOD:CGFloat=1.0
    
    var itemLevelColor=NSColor()
    
    
    init(game: GameClass)
    {
        // generate a completely random piece of equipment
        
        // Generate the iLevel
        // For test purposes this is hard coded to be random, but will scale with player
        iLevel=Int(random(min: 1, max: 20))
        iLevelMod=CGFloat(iLevel)*1.0525
        
        
        // First, pick the type
        invType=Int(random(min: 0, max: CGFloat(game.baseTypesList.count)-0.0000001))
       
        
        
        // Next pick a prefix
        // For now this is hard coded to be more likely to be more common quality...eventually this probably will be replaced with a different system in a different place
        let chance=random(min: 0, max: 1)
        var chanceType=0
        if chance < 0.6
        {
            chanceType=1
        }
        else if chance < 0.75
        {
            chanceType=2
        }
        else if chance < 0.98
        {
            chanceType=3
        }
        else if chance < 0.998
        {
            chanceType=4
        }
        else
        {
            chanceType=5
        }
        
        var foundType=false
        while foundType==false
        {
            prefixNum=Int(random(min: 0, max: CGFloat(game.prefixList.count)-0.0000001))
            if game.prefixList[prefixNum].rarity==chanceType
            {
                foundType=true
            }
        } // while
    
        rarity=chanceType
        if chanceType==1
        {
            itemLevelColor=invColors.COMMON
        }
        else if chanceType==2
        {
            itemLevelColor=invColors.UNCOMMON
        }
        else if chanceType==3
        {
            itemLevelColor=invColors.RARE
        }
        else if chanceType==4
        {
            itemLevelColor=invColors.EPIC
        }
        else if chanceType==5
        {
            itemLevelColor=invColors.LEGENDARY
        }
        
        
        // next pick a suffix
        // Common Types (1) do not have suffices, so use suffixList[0]
        if game.prefixList[prefixNum].rarity==1
        {
            suffixNum=0
        }
        else
        {
            suffixNum=Int(random(min: 1, max: CGFloat(game.suffixList.count)-0.0000001))
        }
        // Get the effects from the suffix
        effects=game.suffixList[suffixNum].effects
        
        // Combine pieces
        
        // first check for weapon effects (such as attack speed)

        
        name="\(game.prefixList[prefixNum].name) \(game.baseTypesList[invType].name) \(game.suffixList[suffixNum].name)"

        
        modLevel=game.prefixList[prefixNum].base*game.baseTypesList[invType].modifier
        
        talentType=game.baseTypesList[invType].talentType
        attackSpeedFactor=game.baseTypesList[invType].modifier
        
        
       if game.prefixList[prefixNum].rarity==1
       {
        statsMod=0
        }
        else
       {
        statsMod=CGFloat(iLevel)*CGFloat(game.prefixList[prefixNum].rarity)/2+BASEEFFECTSMOD
        }
        
        if (effects % suffixEffects.ATTACKSPEED == 0 && game.prefixList[prefixNum].rarity != 1)
        {
            attackSpeedFactor *= 1-statsMod/100
        }
        
        // Testing -- Print out stats
        print("Item name: \(name)")
        print("iLevel: \(iLevel)")
        print("Damage: \(modLevel*iLevelMod)")
        print("Speed: \(attackSpeedFactor)")
        print("#1 Effect: \(getFirstEffectString()) + \(statsMod)")
        print("#2 Effect: \(getSecondEffectString()) + \(statsMod)")
        


    } // init
    
    public func getFirstEffectString() -> String
    {
        var retString:String=""
        if (effects % suffixEffects.STRENGTH == 0)
        {
            retString="Strength"
        }
        else if (effects % suffixEffects.QUICKNESS == 0)
        {
            retString="Quickness"
        }
        else if (effects % suffixEffects.WISDOM == 0)
        {
            retString="Wisdom"
        }
        else if (effects % suffixEffects.HEALTH == 0)
        {
            retString="Health"
        }
        else if (effects % suffixEffects.HEALTHREGEN == 0)
        {
            retString="Health Regeneration"
        }
        else if (effects % suffixEffects.MANA == 0)
        {
            retString="Mana"
        }
        else if (effects % suffixEffects.MANAREGEN == 0)
        {
            retString="Mana Regeneration"
        }
        else if (effects % suffixEffects.MOVESPEED == 0)
        {
            retString="Movement Speed"
        }
        else if (effects % suffixEffects.CRITICAL == 0)
        {
            retString="Critical Chance"
        }
        else if (effects % suffixEffects.ATTACKSPEED == 0)
        {
            retString="Attack Speed"
        }
        
        
        return retString
        
    }
    
    func getSecondEffectString() -> String
    {
        var retString:String=""
        if (effects % suffixEffects.ATTACKSPEED == 0)
        {
            retString="Attack Speed"
        }
        else if (effects % suffixEffects.CRITICAL == 0)
        {
            retString="Critical Chance"
        }
        else if (effects % suffixEffects.MOVESPEED == 0)
        {
            retString="Movement Speed"
        }
        else if (effects % suffixEffects.MOVESPEED == 0)
        {
            retString="Movement Speed"
        }
        else if (effects % suffixEffects.MANAREGEN == 0)
        {
            retString="Mana Regeneration"
        }
        else if (effects % suffixEffects.MANA == 0)
        {
            retString="Mana"
        }
        else if (effects % suffixEffects.HEALTHREGEN == 0)
        {
            retString="Health Regeneration"
        }
        else if (effects % suffixEffects.HEALTH == 0)
        {
            retString="Health"
        }
        else if (effects % suffixEffects.WISDOM == 0)
        {
            retString="Wisdom"
        }
        else if (effects % suffixEffects.QUICKNESS == 0)
        {
            retString="Quickness"
        }
        else if (effects % suffixEffects.STRENGTH == 0)
        {
            retString="Strength"
        }
        
        
        
        return retString
    }
    
} // class BaseInventoryClass

