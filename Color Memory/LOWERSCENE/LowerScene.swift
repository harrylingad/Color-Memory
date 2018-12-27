//
//  LowerScene.swift
//  Color Memory
//
//  Created by Harry Lingad on 22/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SpriteKitEasingSwift



class LowerScene: SKScene{
    
    
    var statsNode: StatsNode?
    var timerNode: TimerNode?
    var pauseNode: PauseNode?
    var refreshNode: RefreshNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        LowerViewDimension.initializeLowerViewDimension(nodeSize: size)
        
        pauseNode = PauseNode(size: LowerViewDimension.pauseNodeSize!)
        pauseNode?.position = LowerViewDimension.pauseNodePosition!
        pauseNode?.anchorPoint = CGPoint(x: 0, y: 1)
        
        refreshNode = RefreshNode(size: LowerViewDimension.refreshNodeSize!)
        refreshNode?.position = LowerViewDimension.refreshNodePosition!
        refreshNode?.anchorPoint = CGPoint(x: 0, y: 1)
        
        pauseNode = PauseNode(size: LowerViewDimension.pauseNodeSize!)
        pauseNode?.position = LowerViewDimension.pauseNodePosition!
        pauseNode?.anchorPoint = CGPoint(x: 0, y: 1)

        
        timerNode = TimerNode(size: LowerViewDimension.timerNodeSize!, time: 0)
        timerNode?.position = LowerViewDimension.timerNodePosition!
        timerNode?.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        self.addChild(timerNode!)
        self.addChild(pauseNode!)
        self.addChild(refreshNode!)
        
        
        
    }
    
    
    
}

