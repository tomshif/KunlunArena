//
//  ToolTipClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 2/3/20.
//  Copyright © 2020 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class ToolTipClass
{
    var game:GameClass?
    var active:Bool=false
    var type:Int=0
    var loot:Int = -1
    var talent:Int = -1
    var ttText=SKLabelNode()

    
    
    init(theGame: GameClass)
    {
        game=theGame
        game!.scene!.addChild(ttText)
        
    }
    
    public func createLoot(num: Int, loc: CGPoint)
    {
        loot=num
        
        // create tooltip text
        ttText.text=game!.lootList[num].name
        ttText.fontColor=game!.lootList[num].itemLevelColor
        ttText.fontName="Arial"
        ttText.fontSize=20
        ttText.name="toolTip"
        ttText.zPosition=750
        
        let ttILText=SKLabelNode(fontNamed: "Arial")
        ttILText.text="Item Level: \(game!.lootList[num].iLevel)"
        ttILText.fontColor=NSColor.white
        ttILText.fontName="Arial"
        ttILText.fontSize=18
        ttILText.name="ttItemlevel"
        ttILText.position.y = -30
        ttILText.zPosition=750
        ttText.addChild(ttILText)
       
       let ttDText=SKLabelNode(fontNamed: "Arial")
        ttDText.text=String(format: "Damage: %2.2f", game!.lootList[num].modLevel*CGFloat(game!.lootList[num].iLevel))
        ttDText.fontColor=NSColor.white
        ttDText.fontName="Arial"
        ttDText.fontSize=18
        ttDText.name="ttDamage"
        ttDText.position.y = -60
        ttDText.zPosition=750
        ttText.addChild(ttDText)
        
        
        let ttHText=SKLabelNode()
        
        ttHText.text=game!.lootList[num].name
        ttHText.fontColor=NSColor.white
        ttHText.fontName="Arial"
        ttHText.fontSize=18
        ttHText.name="ttSpeed"
        ttHText.position.y = -90
        ttHText.text="Speed: \(game!.lootList[num].attackSpeedFactor)"
        ttHText.zPosition=750
        ttText.addChild(ttHText)
        
        
        
        // create toolTip background
        let ttBG=SKShapeNode(rectOf: CGSize(width: ttText.frame.size.width*1.25, height: 150), cornerRadius: 10)
        ttBG.position.y = -ttBG.frame.size.height*0.35
        ttBG.zPosition = -5
        ttBG.fillColor=NSColor.gray
        ttBG.alpha=0.65
        ttBG.strokeColor=NSColor.white
        ttBG.name="toolTipBackground"
        ttText.isHidden=false
        ttText.addChild(ttBG)
        /*
        let ttIL=SKShapeNode(rectOf: CGSize(width: ttText.frame.size.width*1.10, height:ttText.frame.size.height*1.30), cornerRadius: 10)
        ttIL.position.y = -90
        ttIL.zPosition = 750
        ttIL.fillColor=NSColor.white
        ttIL.alpha=0.65
        ttIL.strokeColor=NSColor.white
        ttIL.name="ItemLabel"
        ttText.isHidden=false
        
        
        let ttD=SKShapeNode(rectOf: CGSize(width: ttText.frame.size.width*1.10, height:ttText.frame.size.height*1.30), cornerRadius: 10)
        ttD.position.y = -70
        ttD.zPosition=750
        ttD.fillColor=NSColor.white
        ttD.alpha=0.65
        ttD.strokeColor=NSColor.white
        ttD.name="Damage"
        ttText.isHidden=false
        ttText.addChild(ttDText)
        
        
        let ttH=SKShapeNode(rectOf: CGSize(width: ttText.frame.size.width*1.10, height:ttText.frame.size.height*1.30), cornerRadius: 10)
        ttH.position.y = -100
        ttH.zPosition = 750
        ttH.fillColor=NSColor.white
        ttH.alpha=0.65
        ttH.strokeColor=NSColor.white
        ttH.name="Heal"
        ttText.isHidden=false
        ttText.addChild(ttHText)
        */
        
        
        active=true
    } // createLoot

    public func createTalent(num: Int)
    {
        
    } // createTalent
    
    public func updateToolTip(loc: CGPoint)
    {
        ttText.position=loc
    } // updateToolTip()
    
    public func removeToolTip()
    {
        active=false
        ttText.isHidden=true
        loot = -1
        talent = -1
        ttText.removeAllChildren()

    } // removeToolTip()
    
} // class ToolTipClass
