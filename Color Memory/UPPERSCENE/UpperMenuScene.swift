//
//  UpperMenuScene.swift
//  Color Memory
//
//  Created by Harry Lingad on 15/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SpriteKitEasingSwift



class UpperMenuScene: SKScene{
    
    
    var statsNode: StatsNode?
    var levelNode: LevelNode?
    var scoreNode: ScoreNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        statsNode = StatsNode(texture: nil, color: UIColor.red, size: GameDimension.statsNodeSize(nodeSize: size))
        statsNode?.position = GameDimension.statsNodeDimension(nodeSize: size)
        statsNode?.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        levelNode = LevelNode(texture: nil, color: UIColor.gray, size: GameDimension.levelNodeSize(nodeSize: size) )
        levelNode?.position = GameDimension.levelNodeDimension(nodeSize: size)
        levelNode?.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        
        scoreNode = ScoreNode(size: GameDimension.scoreNodeSize(nodeSize: size), score: 0)
        scoreNode?.position = GameDimension.scoreNodeDimension(nodeSize: size)
        scoreNode?.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        
        self.addChild(statsNode!)
        self.addChild(levelNode!)
        self.addChild(scoreNode!)
        
        
        
    }
    

    
}
