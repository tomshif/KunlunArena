//
//  EntityClass.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
//

import Foundation
import SpriteKit

class EntityClass:Codable
{
    var name:String
    var headNum:Int
    var bodyNum:Int
    var legsNum:Int
    
    init()
    {
        name="Test"
        headNum=0
        bodyNum=0
        legsNum=0
    }
    
    
    /*
    private enum CodingKeys: String, CodingKey {
        case name
        case headNum
        case bodyNum
        case legsNum
        
    } // CodingKeys
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.headNum = try container.decode(Int.self, forKey: .headNum)
        self.bodyNum = try container.decode(Int.self, forKey: .bodyNum)
        self.legsNum = try container.decode(Int.self, forKey: .legsNum)
    } // decode init
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(headNum, forKey: .headNum)
        try container.encode(bodyNum, forKey: .bodyNum)
        try container.encode(legsNum, forKey: .legsNum)
        

    }
    */
    
    
} // class EntityClass


