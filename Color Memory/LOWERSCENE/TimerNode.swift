//
//  TimerNode.swift
//  Color Memory
//
//  Created by Harry Lingad on 22/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation

import SpriteKit

class TimerNode: SKSpriteNode{
    
    var timerValueNode: SKLabelNode?
    var time: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(texture: nil, color: UIColor.gray, size: CGSize(width: 0, height: 0))
        self.time = 0
        self.timerValueNode = SKLabelNode()
        
    }
    
    
    init(size: CGSize, time: Int){
        
        super.init(texture: nil, color: UIColor.gray, size: size)
        
        self.time = time
        
        
        
        let timerLabelNode = SKLabelNode(fontNamed: "Avenir-Light")
        timerLabelNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        timerLabelNode.text = "TIMER"
        timerLabelNode.fontSize = ((size.width) * 0.25)
        timerLabelNode.fontColor = UIColor.black
        
        timerValueNode = SKLabelNode(fontNamed: "Avenir-Light")
        timerValueNode?.position = CGPoint(x: self.size.width * 0.5, y: -self.size.height * 0.3)
        timerValueNode?.text = "\(String(describing: self.time))"
        timerValueNode?.fontSize = ((size.width) * 0.3)
        timerValueNode?.fontColor = UIColor.black
        
        self.addChild(timerLabelNode)
        self.addChild(timerValueNode!)
        
    }
    
    func setTime(time: Int){
        self.time = time
        self.timerValueNode?.text = "\(self.time)"
    }
}

