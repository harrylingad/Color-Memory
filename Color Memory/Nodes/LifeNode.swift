//
//  LifeNode.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 12/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit

class LifeNode: SKSpriteNode{
    
//    var lifeNodes: [SKSpriteNode]?
    var lifeCount: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(size: CGSize, lifeCount: Int){
//        super.init(texture: nil, color: UIColor.black, size: CGSize(width: ((size.width * 0.06) * 4), height: size.width * 0.06))
//        self.position = CGPoint(x: (self.size.height * 0.5) + (self.size.width * 0.5), y: (size.height - self.size.height))
        
        super.init(texture: nil, color: UIColor.green, size: size)
        self.position = CGPoint(x: 0, y: 0)
        
        
        
        
        let nodeSize = CGSize(width: self.size.height * 0.5, height: self.size.height * 0.5)
        let nodePosition = CGPoint(x: 0, y: 0)
        let newLifeNode = SKSpriteNode(texture: GameAsset.darkBlueTexture, size: nodeSize)
        newLifeNode.position = nodePosition
        
        self.addChild(newLifeNode)
        
//        var nodePosition = CGPoint(x: -nodeSize.width * 1.5, y: 0)
        
//        var nodePosition = CGPoint(x: 0, y: 0)
//        self.lifeCount = lifeCount
//        self.isAlive = true
//
//        lifeNodes = [SKSpriteNode]()
//
//        var i = 0
//        while i < 3{
//            let newLifeNode = SKSpriteNode(texture: GameAsset.blueTexture, size: nodeSize)
//            newLifeNode.position = CGPoint(x: 0, y: 0)
//
////            nodePosition.x = nodePosition.x + (nodeSize.width * 1.5)
//
//            self.addChild(newLifeNode)
//            lifeNodes?.append(newLifeNode)
//            i += 1
//        }
    }
    
    
//    func removeLife(){
//
//        lifeCount = lifeCount! - 1
//        var i = 0
//        while i < (lifeNodes?.count)!{
//
//            if i < lifeCount!{
//                lifeNodes![i].texture = GameAsset.blueTexture
//            }else{
//                lifeNodes![i].texture = GameAsset.redTexture
//            }
//
//            i += 1
//        }
//
//    }
    
    
    func checkLifeCount() -> Bool{
        if lifeCount! < 1{
            return false
        }
        return true
        
    }
    
    
}
