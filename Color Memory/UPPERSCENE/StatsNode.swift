//
//  StatsNode.swift
//  Color Memory
//
//  Created by Harry Lingad on 16/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit

class StatsNode: SKSpriteNode{
    

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        //addShuffleSquares()
        addLifeSquare()
        
    }
    
    func addShuffleSquares(){
        
        let newSquaresLabel = SKLabelNode(fontNamed:"Avenir-Light")
        newSquaresLabel.text = "SHUFFLE"
        newSquaresLabel.fontSize = ((self.size.height) * 0.35)
        newSquaresLabel.fontColor = UIColor.white
        newSquaresLabel.position = GameDimension.shuffleLabelPosition(nodeSize: self.size)
        
        self.addChild(newSquaresLabel)
    }
    
    func addLifeSquare(){
        
        let square1 = SKSpriteNode(color: CMColor.cmColorYellow(), size: GameDimension.lifeSquareSize(nodeSize: self.size))
        square1.position = GameDimension.lifeSquareDimension(nodeSize: size, squareSize: square1.size).firstDim
        square1.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        let square2 = SKSpriteNode(color: CMColor.cmColorYellow(), size: GameDimension.lifeSquareSize(nodeSize: self.size))
        square2.position = GameDimension.lifeSquareDimension(nodeSize: size, squareSize: square2.size).middleDim
        square2.anchorPoint = CGPoint(x: 0, y: 0.5)

        let square3 = SKSpriteNode(color: CMColor.cmColorYellow(), size: GameDimension.lifeSquareSize(nodeSize: self.size))
        square3.position = GameDimension.lifeSquareDimension(nodeSize: size, squareSize: square3.size).lastDim
        square3.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        self.addChild(square1)
        self.addChild(square2)
        self.addChild(square3)
        
    }
    
}
