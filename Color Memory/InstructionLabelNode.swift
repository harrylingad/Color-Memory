//
//  InstructionLabelNode.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 01/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit


class InstructionLabelNode: SKSpriteNode{
    
    var memorizeInLN: SKLabelNode?
//    var countdownTimerLN: SKLabelNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: UIColor.clear, size: size)
        
        self.size = CGSize(width: size.width, height: size.height * 0.1 )
        self.position = CGPoint(x: size.width / 2, y: self.size.height * 0.5)

        memorizeInLN = SKLabelNode(fontNamed:"Avenir-Light")
        memorizeInLN?.text = ""
        memorizeInLN?.fontSize = ((self.size.height) * 0.5)
        memorizeInLN?.fontColor = UIColor.white
        memorizeInLN?.position = CGPoint(x: 0, y: 0)

//        countdownTimerLN = SKLabelNode(fontNamed:"Avenir-Light")
//        countdownTimerLN?.text = "5"
//        countdownTimerLN?.fontSize = ((self.size.height) * 0.5)
//        countdownTimerLN?.fontColor = UIColor.white
//        countdownTimerLN?.position = CGPoint(x: 0, y: -(countdownTimerLN?.fontSize)! * 0.8)

        self.addChild(memorizeInLN!)
        //self.addChild(countdownTimerLN!)
        
        
    }
    
    func setToRearranging(){
        self.memorizeInLN?.text = "Rearranging..."
        //self.countdownTimerLN?.text = "Rearranging..."
        //self.countdownTimerLN?.fontSize = (self.memorizeInLN?.fontSize)!
    }
    
    func setToStart(){
        self.memorizeInLN?.text = "Start"
    }
    
}
