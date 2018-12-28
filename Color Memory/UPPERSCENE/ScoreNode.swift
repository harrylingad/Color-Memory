//
//  ScoreNode.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 14/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation

import SpriteKit

class ScoreNode: SKSpriteNode{
    
    var scoreValueNode: SKLabelNode?
    
    var score: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(texture: nil, color: CMColor.cmColorBlue() , size: CGSize(width: 0, height: 0))
        self.score = 0
        self.scoreValueNode = SKLabelNode()
        
    }
    

    init(size: CGSize, score: Int){
        super.init(texture: nil, color: CMColor.cmColorBlue(), size: size)
        
        self.score = score
        
        
        
        let scoreLabelNode = SKLabelNode(fontNamed: "Avenir-Light")
        scoreLabelNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        scoreLabelNode.text = "SCORE"
        scoreLabelNode.fontSize = ((size.width) * 0.25)
        scoreLabelNode.fontColor = UIColor.black
        
        scoreValueNode = SKLabelNode(fontNamed: "Avenir-Bold")
        scoreValueNode?.position = CGPoint(x: self.size.width * 0.5, y: -self.size.height * 0.3)
        scoreValueNode?.text = "\(String(describing: self.score))"
        scoreValueNode?.fontSize = ((size.width) * 0.3)
        scoreValueNode?.fontColor = UIColor.black
        
        self.addChild(scoreLabelNode)
        self.addChild(scoreValueNode!)
      
    }
    
    func setScore(score: Int){
        self.score = score
        self.scoreValueNode?.text = "\(self.score)"
    }
     
}
