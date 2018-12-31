//
//  RefreshNode.swift
//  Color Memory
//
//  Created by Harry Lingad on 26/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit

class RefreshNode: SKSpriteNode{
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(texture: nil, color: CMColor.cmColorRed(), size: CGSize(width: 0, height: 0))
        
    }
    
    
    init(size: CGSize){
        
        super.init(texture: nil, color: CMColor.cmColorViolet(), size: size)
        let timerLabelNode = SKLabelNode(fontNamed: "Avenir-Bold")
        timerLabelNode.position = CGPoint(x: self.size.width * 0.5, y: -(self.size.height * 0.75))
        timerLabelNode.text = "REFRESH"
        timerLabelNode.fontSize = ((size.width) * 0.15)
        timerLabelNode.fontColor = UIColor.black
        
        self.addChild(timerLabelNode)
    }
    
    
}

