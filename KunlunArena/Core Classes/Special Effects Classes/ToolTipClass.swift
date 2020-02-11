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
        ttText.fontSize=24
        ttText.name="toolTip"
        ttText.zPosition=750
        ttText.position=loc
        
        
        // create toolTip background
        let ttBG=SKShapeNode(rectOf: CGSize(width: ttText.frame.size.width*1.25, height: ttText.frame.size.height*1.5), cornerRadius: 10)
        ttBG.position.y=ttBG.frame.size.height*0.25
        ttBG.zPosition = -5
        ttBG.fillColor=NSColor.gray
        ttBG.alpha=0.65
        ttBG.strokeColor=NSColor.white
        ttBG.name="toolTipBackground"
        ttText.isHidden=false
        ttText.addChild(ttBG)
        
        let ttIL=SKShapeNode(rectOf: CGSize(width: ttText.frame.size.width*1.10, height:ttText.frame.size.height*1.30), cornerRadius: 10)
        ttIL.position.y=ttIL.frame.size.height*0.15
        ttIL.zPosition = 305
        ttIL.fillColor=NSColor.white
        ttIL.alpha=0.65
        ttIL.strokeColor=NSColor.white
        ttIL.name="ItemLabel"
        ttText.isHidden=false
        ttText.addChild(ttIL)
        
        let ttD=SKShapeNode(rectOf: CGSize(width: ttText.frame.size.width*1.10, height:ttText.frame.size.height*1.30), cornerRadius: 10)
        ttD.position.y=ttD.frame.size.height*0.35
        ttD.zPosition=305
        ttD.fillColor=NSColor.white
        ttD.alpha=0.65
        ttD.strokeColor=NSColor.white
        ttD.name="Damage"
        ttText.isHidden=false
        ttText.addChild(ttD)
        
        let ttH=SKShapeNode(rectOf: CGSize(width: ttText.frame.size.width*1.10, height:ttText.frame.size.height*1.30), cornerRadius: 10)
        ttH.position.y=ttIL.frame.size.height*0.65
        ttH.zPosition = 305
        ttH.fillColor=NSColor.white
        ttH.alpha=0.65
        ttH.strokeColor=NSColor.white
        ttH.name="Heal"
        ttText.isHidden=false
        ttText.addChild(ttH)
        
        
        
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
