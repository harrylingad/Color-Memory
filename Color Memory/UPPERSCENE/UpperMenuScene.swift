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
        
        UpperViewDimension.initializeUpperViewDimension(nodeSize: size)
        
        statsNode = StatsNode(texture: nil, color: CMColor.cmColorLightGreen() , size: UpperViewDimension.statsNodeSize!)
        statsNode?.position = UpperViewDimension.statsNodePosition!
        statsNode?.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        levelNode = LevelNode(texture: nil, color: CMColor.cmColorBlue(), size: UpperViewDimension.levelNodeSize! )
        levelNode?.position = UpperViewDimension.levelNodePosition!
        levelNode?.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        
        scoreNode = ScoreNode(size: UpperViewDimension.scoreNodeSize!, score: 0)
        scoreNode?.position = UpperViewDimension.scoreNodePosition!
        scoreNode?.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        
        self.addChild(statsNode!)
        self.addChild(levelNode!)
        self.addChild(scoreNode!)
        
        
        
    }
    

    
}
