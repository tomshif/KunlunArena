//
//  InventoryInit.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 1/22/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//
// This function will initialize all inventory prefixes and suffixes into a consistent array so that items can be accessed by prefix number and suffix number

// This will be called one time in the didMove() function of the GameScene.



import Foundation
import SpriteKit

func initInventory(game: GameClass)
{
    
    // Add in each of the base types
    let type00=BaseInvTypesClass(n: "Jian", m: 0.75,t: 0)
    game.baseTypesList.append(type00)
    
    let type01=BaseInvTypesClass(n: "Dao", m: 1.0,t: 0)
    game.baseTypesList.append(type01)
    
    let type02=BaseInvTypesClass(n: "Changdao", m: 1.25,t: 0)
    game.baseTypesList.append(type02)
    
    let type03=BaseInvTypesClass(n: "Liuyedao", m: 1.3,t: 0)
    game.baseTypesList.append(type03)
    
    let type04=BaseInvTypesClass(n: "Nandao", m: 1.4,t: 0)
    game.baseTypesList.append(type04)
    
    let type05=BaseInvTypesClass(n: "Yanyuedao", m: 1.5,t: 0)
    game.baseTypesList.append(type05)
    
    let type06=BaseInvTypesClass(n: "Bang", m: 0.8,t: 1)
    game.baseTypesList.append(type06)
    
    let type07=BaseInvTypesClass(n: "Guan", m: 1.0,t: 1)
    game.baseTypesList.append(type07)
    
    let type08=BaseInvTypesClass(n: "Yanyuedao", m: 1.2,t: 1)
    game.baseTypesList.append(type08)
    
    let type09=BaseInvTypesClass(n: "Chang Guan", m: 1.2,t: 1)
    game.baseTypesList.append(type09)
    
    let type10=BaseInvTypesClass(n: "Bian", m: 1.3,t: 1)
    game.baseTypesList.append(type10)
    
    let type11=BaseInvTypesClass(n: "Sanjiegun", m: 1.3,t: 1)
    game.baseTypesList.append(type11)
    
    let type12=BaseInvTypesClass(n: "Chan", m: 1.3,t: 1)
    game.baseTypesList.append(type12)
    
    let type13=BaseInvTypesClass(n: "Self Bow", m: 0.8,t: 2)
    game.baseTypesList.append(type13)
    
    let type14=BaseInvTypesClass(n: "Reflex Bow", m: 1.0,t: 2)
    game.baseTypesList.append(type14)
    
    let type15=BaseInvTypesClass(n: "Laminate Bow", m: 1.2,t: 2)
    game.baseTypesList.append(type15)
    
    let type16=BaseInvTypesClass(n: "Horn Bow", m: 1.3,t: 2)
    game.baseTypesList.append(type16)
    
    let type17=BaseInvTypesClass(n: "Scythian Bow", m: 1.5,t: 2)
    game.baseTypesList.append(type17)
    
    let type18=BaseInvTypesClass(n: "Light Crossbow", m: 0.8,t: 3)
    game.baseTypesList.append(type18)
    
    let type19=BaseInvTypesClass(n: "Crossbow", m: 1.0,t: 3)
    game.baseTypesList.append(type19)
    
    let type20=BaseInvTypesClass(n: "Heavy Crossbow", m: 1.2,t: 3)
    game.baseTypesList.append(type20)
    
    let type21=BaseInvTypesClass(n: "Hand Cannon", m: 1.3,t: 3)
    game.baseTypesList.append(type21)
    
    let type22=BaseInvTypesClass(n: "Fire Lance", m: 1.5,t: 3)
    game.baseTypesList.append(type22)
    
    let type23=BaseInvTypesClass(n: "Sickle", m: 0.8,t: 4)
    game.baseTypesList.append(type23)
    
    let type24=BaseInvTypesClass(n: "Hammer", m: 1.0,t: 4)
    game.baseTypesList.append(type24)
    
    let type25=BaseInvTypesClass(n: "Broomstick", m: 1.2,t: 4)
    game.baseTypesList.append(type25)
    
    let type26=BaseInvTypesClass(n: "Pitchfork", m: 1.3,t: 4)
    game.baseTypesList.append(type26)
    
    let type27=BaseInvTypesClass(n: "Scythe", m: 1.5,t: 4)
    game.baseTypesList.append(type27)
    
    let type28=BaseInvTypesClass(n: "Fuozhu", m: 0.85,t: 5)
    game.baseTypesList.append(type28)
    
    let type29=BaseInvTypesClass(n: "Zhuanjingtong", m: 1.0,t: 5)
    game.baseTypesList.append(type29)
    
    let type30=BaseInvTypesClass(n: "Sacred Mallet-TEMP", m: 1.2,t: 5)
    game.baseTypesList.append(type30)
    
    let type31=BaseInvTypesClass(n: "Fuchen", m: 1.3,t: 5)
    game.baseTypesList.append(type31)
    
    let type32=BaseInvTypesClass(n: "Ru Yi", m: 1.5,t: 5)
    game.baseTypesList.append(type32)

    // WEAPONS ^^^
    
    
    let type33=BaseInvTypesClass(n: "Helmet", m: 1, t: 1)
    game.baseTypesList.append(type33)
    
    let type34=BaseInvTypesClass(n: "Helm", m: 1, t: 1)
       game.baseTypesList.append(type34)
    
    let type35=BaseInvTypesClass(n: "Hat", m: 1, t: 1)
       game.baseTypesList.append(type35)
    
    let type36=BaseInvTypesClass(n: "Cap", m: 1, t: 1)
       game.baseTypesList.append(type36)
    
    let type37=BaseInvTypesClass(n: "Skull Cap", m: 1, t: 1)
       game.baseTypesList.append(type37)
    
    let type38=BaseInvTypesClass(n: "Combat Helmet", m: 1, t: 1)
       game.baseTypesList.append(type38)
    
    let type39=BaseInvTypesClass(n: "Warring States Helmet", m: 1, t: 1)
       game.baseTypesList.append(type39)
    
    let type40=BaseInvTypesClass(n: "Mask", m: 1, t: 1)
       game.baseTypesList.append(type40)
    
    let type41=BaseInvTypesClass(n: "Han Helmet", m: 1, t: 1)
       game.baseTypesList.append(type41)
    
    let type42=BaseInvTypesClass(n: "Plate Helm", m: 1, t: 1)
       game.baseTypesList.append(type42)
    
    let type43=BaseInvTypesClass(n: "Jin Helm", m: 1, t: 1)
       game.baseTypesList.append(type43)
    
    let type44=BaseInvTypesClass(n: "Yuan Cap", m: 1, t: 1)
    game.baseTypesList.append(type44)
    
    let type45=BaseInvTypesClass(n: "Mongol Hat", m: 1, t: 1)
    game.baseTypesList.append(type45)
    
    let type46=BaseInvTypesClass(n: "Ming Phoenix Helmet", m: 1, t: 1)
    game.baseTypesList.append(type46)
    
    let type47=BaseInvTypesClass(n: "Qing Parade Helmet", m: 1, t: 1)
    game.baseTypesList.append(type47)
    
    // HELMETS ^^^
    
    
    // Add each of the prefixes to the list
    
    let pre00=PrefixClass()
    pre00.name="Iron"
    pre00.rarity=1
    pre00.base=5.0
    game.prefixList.append(pre00)
    
    let pre01=PrefixClass()
    pre01.name="Rusty"
    pre01.rarity=1
    pre01.base=4.0
    game.prefixList.append(pre01)
    
    let pre02=PrefixClass()
    pre02.name="Chipped"
    pre02.rarity=1
    pre02.base=3.5
    game.prefixList.append(pre02)
    
    let pre03=PrefixClass()
    pre03.name="Dented"
    pre03.rarity=1
    pre03.base=3.5
    game.prefixList.append(pre03)
    
    let pre04=PrefixClass()
    pre04.name="Unbalanced"
    pre04.rarity=1
    pre04.base=3.5
    game.prefixList.append(pre04)
    
    let pre05=PrefixClass()
    pre05.name="Worn"
    pre05.rarity=1
    pre05.base=3.0
    game.prefixList.append(pre05)
    
    let pre06=PrefixClass()
    pre06.name="Jagged"
    pre06.rarity=2
    pre06.base=7.5
    game.prefixList.append(pre06)
    
    let pre07=PrefixClass()
    pre07.name="Sharp"
    pre07.rarity=2
    pre07.base=7.5
    game.prefixList.append(pre07)
    
    let pre08=PrefixClass()
    pre08.name="Balanced"
    pre08.rarity=2
    pre08.base=7.0
    game.prefixList.append(pre08)
    
    let pre09=PrefixClass()
    pre09.name="Slicing"
    pre09.rarity=2
    pre09.base=6
    game.prefixList.append(pre09)
    
    let pre10=PrefixClass()
    pre10.name="Tempered"
    pre10.rarity=2
    pre10.base=5.5
    game.prefixList.append(pre10)
    
    let pre11=PrefixClass()
    pre11.name="Meteorite"
    pre11.rarity=3
    pre11.base=8.5
    game.prefixList.append(pre11)
    
    let pre12=PrefixClass()
    pre12.name="Lightning"
    pre12.rarity=3
    pre12.base=8.0
    game.prefixList.append(pre12)
    
    let pre13=PrefixClass()
    pre13.name="Starfall"
    pre13.rarity=3
    pre13.base=7.5
    game.prefixList.append(pre13)
    
    let pre14=PrefixClass()
    pre14.name="Volcanic"
    pre14.rarity=3
    pre14.base=7.5
    game.prefixList.append(pre14)
    
    let pre15=PrefixClass()
    pre15.name="Jade"
    pre15.rarity=4
    pre15.base=11
    game.prefixList.append(pre15)
    
    let pre16=PrefixClass()
    pre16.name="Diamond"
    pre16.rarity=4
    pre16.base=10.5
    game.prefixList.append(pre16)
    
    let pre17=PrefixClass()
    pre17.name="Ruby"
    pre17.rarity=4
    pre17.base=10
    game.prefixList.append(pre17)
    
    let pre18=PrefixClass()
    pre18.name="Sapphire"
    pre18.rarity=4
    pre18.base=8
    game.prefixList.append(pre18)
    
    let pre19=PrefixClass()
    pre19.name="Qin Shi's"
    pre19.rarity=5
    pre19.base=14
    game.prefixList.append(pre19)
    
    let pre20=PrefixClass()
    pre20.name="Taizong's"
    pre20.rarity=5
    pre20.base=13.5
    game.prefixList.append(pre20)
    
    let pre21=PrefixClass()
    pre21.name="Khan's"
    pre21.rarity=5
    pre21.base=13
    game.prefixList.append(pre21)
    
    let pre22=PrefixClass()
    pre22.name="Gaozu's"
    pre22.rarity=5
    pre22.base=12.5
    game.prefixList.append(pre22)
    
    let pre23=PrefixClass()
    pre23.name="Kongxi's"
    pre23.rarity=5
    pre23.base=12.5
    game.prefixList.append(pre23)
    
    
    // add each one of the suffixes to the list
    let noSuffix=SuffixClass()
    noSuffix.name=""
    noSuffix.effects=5801 // Just pick a really high prime number
    game.suffixList.append(noSuffix)
    
    
    let suf00=SuffixClass()
    suf00.name="of the Rat"
    suf00.effects=suffixEffects.STRENGTH*suffixEffects.MOVESPEED
    game.suffixList.append(suf00)
    
    let suf01=SuffixClass()
    suf01.name="of the Goat"
    suf01.effects=suffixEffects.STRENGTH*suffixEffects.HEALTHREGEN
    game.suffixList.append(suf01)
    
    let suf02=SuffixClass()
    suf02.name="of the Monkey"
    suf02.effects=suffixEffects.STRENGTH*suffixEffects.MANAREGEN
    game.suffixList.append(suf02)
    
    let suf03=SuffixClass()
    suf03.name="of the Ox"
    suf03.effects=suffixEffects.STRENGTH*suffixEffects.HEALTH
    game.suffixList.append(suf03)
    
    let suf04=SuffixClass()
    suf04.name="of the Earth"
    suf04.effects=suffixEffects.STRENGTH*suffixEffects.MANA
    game.suffixList.append(suf04)
    
    let suf05=SuffixClass()
    suf05.name="of the Valley"
    suf05.effects=suffixEffects.STRENGTH*suffixEffects.ATTACKSPEED
    game.suffixList.append(suf05)
    
    let suf06=SuffixClass()
    suf06.name="of the Mountain"
    suf06.effects=suffixEffects.HEALTH*suffixEffects.HEALTHREGEN
    game.suffixList.append(suf06)
    
    let suf07=SuffixClass()
    suf07.name="of the Canyon"
    suf07.effects=suffixEffects.MANA*suffixEffects.HEALTH
    game.suffixList.append(suf07)
    
    let suf08=SuffixClass()
    suf08.name="of the Forest"
    suf08.effects=suffixEffects.MANA*suffixEffects.MANAREGEN
    game.suffixList.append(suf08)
    
    let suf09=SuffixClass()
    suf09.name="of the Horse"
    suf09.effects=suffixEffects.QUICKNESS*suffixEffects.HEALTH
    game.suffixList.append(suf09)
    
    let suf10=SuffixClass()
    suf10.name="of the Rabbit"
    suf10.effects=suffixEffects.QUICKNESS*suffixEffects.MOVESPEED
    game.suffixList.append(suf10)
    
    let suf11=SuffixClass()
    suf11.name="of the Rooster"
    suf11.effects=suffixEffects.QUICKNESS*suffixEffects.MANAREGEN
    game.suffixList.append(suf11)
    
    let suf12=SuffixClass()
    suf12.name="of the Tiger"
    suf12.effects=suffixEffects.QUICKNESS*suffixEffects.HEALTHREGEN
    game.suffixList.append(suf12)
    
    let suf13=SuffixClass()
    suf13.name="of the Wind"
    suf13.effects=suffixEffects.QUICKNESS*suffixEffects.MANA
    game.suffixList.append(suf13)
    
    let suf14=SuffixClass()
    suf14.name="of the Gale"
    suf14.effects=suffixEffects.QUICKNESS*suffixEffects.ATTACKSPEED
    game.suffixList.append(suf14)
    
    let suf15=SuffixClass()
    suf15.name="of the Flag"
    suf15.effects=suffixEffects.HEALTH*suffixEffects.HEALTHREGEN
    game.suffixList.append(suf15)
    
    let suf16=SuffixClass()
    suf16.name="of the Rabbit"
    suf16.effects=suffixEffects.MANA*suffixEffects.HEALTH
    game.suffixList.append(suf16)
    
    let suf17=SuffixClass()
    suf17.name="of the Waves"
    suf17.effects=suffixEffects.MANA*suffixEffects.MANAREGEN
    game.suffixList.append(suf17)
    
    let suf18=SuffixClass()
    suf18.name="of the Snake"
    suf18.effects=suffixEffects.WISDOM*suffixEffects.MOVESPEED
    game.suffixList.append(suf18)
    
    let suf19=SuffixClass()
    suf19.name="of the Dog"
    suf19.effects=suffixEffects.WISDOM*suffixEffects.MANAREGEN
    game.suffixList.append(suf19)
    
    let suf20=SuffixClass()
    suf20.name="of the Pig"
    suf20.effects=suffixEffects.WISDOM*suffixEffects.HEALTHREGEN
    game.suffixList.append(suf20)
    
    let suf21=SuffixClass()
    
    suf21.name="of the Dragon"
    suf21.effects=suffixEffects.WISDOM*suffixEffects.MANA
    game.suffixList.append(suf21)
    
    let suf22=SuffixClass()
    suf22.name="of the Fire"
    suf22.effects=suffixEffects.WISDOM*suffixEffects.HEALTH
    game.suffixList.append(suf22)
    
    let suf23=SuffixClass()
    suf23.name="of the Inferno"
    suf23.effects=suffixEffects.STRENGTH*suffixEffects.ATTACKSPEED
    game.suffixList.append(suf23)
    
    let suf24=SuffixClass()
    suf24.name="of Creation"
    suf24.effects=suffixEffects.HEALTH*suffixEffects.HEALTHREGEN
    game.suffixList.append(suf24)
    
    let suf25=SuffixClass()
    suf25.name="of the Wildfire"
    suf25.effects=suffixEffects.MANA*suffixEffects.HEALTH
    game.suffixList.append(suf25)
    
    let suf26=SuffixClass()
    suf26.name="of Blazing"
    suf26.effects=suffixEffects.MANA*suffixEffects.MANAREGEN
    game.suffixList.append(suf26)
    
}
