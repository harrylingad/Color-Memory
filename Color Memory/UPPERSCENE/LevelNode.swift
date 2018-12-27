//
//  LevelNode.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 15/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit

class LevelNode: SKSpriteNode{
    
    var levelNode: Int?
    var section: Int?
    var levelLabelNode: SKLabelNode?
    var levelValueNode: SKLabelNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
      
        self.levelNode = 0
        self.section = 0
        
        
        let levelLabelNode = SKLabelNode(fontNamed: "Avenir-Light")
        levelLabelNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        levelLabelNode.text = "LEVEL"
        levelLabelNode.fontSize = ((size.width) * 0.25)
        levelLabelNode.fontColor = UIColor.black
        self.addChild(levelLabelNode)
        
        
        
        levelValueNode = SKLabelNode(fontNamed: "Avenir-Light")
        levelValueNode?.position = CGPoint(x: self.size.width * 0.5, y: -self.size.height * 0.3)
        levelValueNode?.text = "\(self.levelNode ?? 0) - \(self.section ?? 0)"
        levelValueNode?.fontSize = ((size.width) * 0.3)
        levelValueNode?.fontColor = UIColor.black
        
        self.addChild(levelValueNode!)
        
    }
    


    

    

    func setLevel(levelNode: Int, sectionNode: Int){
        levelLabelNode?.text = "\(levelNode) - \(sectionNode)"
    }
    
    
    
    
}


