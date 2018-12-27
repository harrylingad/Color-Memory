//
//  SquareObject.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 03/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit

class SquareNode: SKSpriteNode{
    
    var isActive: Bool = false
    var origPosition = CGPoint(x: 0, y: 0)
    var finalPosition: CGPoint?
    var id: Int = 0
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(texture: SKTexture?, color: UIColor, size: CGSize, isActive: Bool, id: Int) {
        super.init(texture: texture, color: color, size: size)
        self.isActive = isActive
        self.origPosition = CGPoint(x: 0, y: 0)
        self.id = id
        
    }
    
    init(texture: SKTexture?, point: CGPoint, size: CGSize, isActive: Bool, id: Int) {
        super.init(texture: texture, color: UIColor.white, size: size)
        self.isActive = isActive
        self.origPosition = CGPoint(x: 0, y: 0)
        self.id = id
        self.position = point
        
    }
    
    init(texture: SKTexture?, size: CGSize, isActive: Bool, finalPosition: CGPoint, id: Int){
        super.init(texture: texture, color: UIColor.white, size: size)
        self.isActive = isActive
        self.origPosition = finalPosition
        //self.origPosition = CGPoint(x: -self.size.width, y: -self.size.height)
        //self.position = self.origPosition
        self.position = finalPosition
        self.finalPosition = finalPosition
        self.id = id
    }
    

    

    
    
}
