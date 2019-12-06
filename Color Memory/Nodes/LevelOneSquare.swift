//
//  LevelOneSquare.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 09/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit
import GLKit
import GameplayKit


class LevelOneSquare: SKSpriteNode{
    
    var squares: [SquareNode]?
    var levelId: String = ""
    var parentViewSize: CGSize?
    var squareSize: CGSize?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(squareNumber: Int, size: CGSize) {
        parentViewSize = size
        
        let halfOfSquareNumber = CGFloat(squareNumber) * 0.5
        let divident = 1.0 / CGFloat(halfOfSquareNumber + 2)
        let widthOfSquare = (parentViewSize?.width)! * divident
        let selfWidth = widthOfSquare * (CGFloat(squareNumber) * 0.5)
        let selfHeight = widthOfSquare * 2
        
        let levelOneSquareSize = CGSize(width: selfWidth, height: selfHeight)
        
        super.init(texture: nil, color: UIColor.white, size: levelOneSquareSize)
        self.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
        
        squares = [SquareNode]()
        
        self.squareSize = self.setSquareSize(squareCount: squareNumber)
        self.size = self.setSize(squareNumber: squareNumber)
        
        var index = 0
        var referenceIDArray = [Int]()
        while index < squareNumber{
            referenceIDArray.append(index)
            index += 1
        }
        
        
        var i = 1
        while i <= squareNumber{
            
            let squarePosition = getSquarePosition(squareCount: squareNumber, squareIndex: i)
            
            
            let randomNumberDistribution = GKRandomDistribution(lowestValue: 0, highestValue: referenceIDArray.count - 1)
            let squareIDIndex = randomNumberDistribution.nextInt()
            
            
            let idValue = referenceIDArray[squareIDIndex]
            
            referenceIDArray = removeSquare(toBeRemoveID: idValue, toBeRemoveFromArray: referenceIDArray)
            levelId = levelId + "\(idValue)"
            
            let square = SquareNode(texture: getTexture(textureID: idValue), point: squarePosition, size: squareSize!, isActive: false, id: idValue)
            
            self.addChild(square)
            squares?.append(square)
            i += 1
        }
        
        print(levelId)
        
    }
    
    func setSize(squareNumber: Int) -> CGSize{
        
        let halfOfSquareNumber = CGFloat(squareNumber) * 0.5
        let divident = 1.0 / CGFloat(halfOfSquareNumber + 2)
        let widthOfSquare = (parentViewSize?.width)! * divident
        let selfWidth = widthOfSquare * (CGFloat(squareNumber) * 0.5)
        let selfHeight = widthOfSquare * 2
        
        return CGSize(width: selfWidth, height: selfHeight)
    }
    
    func getPosition(squareCount: Int, squareIndex: Int, xPosition: Int, yPosition: Int) -> (x: Int, y: Int){
        
        // FOR POSITION X
        var x: Int
        if squareIndex%(squareCount/2) != 0{
            x = Int(-xPosition)
        }else{
            x = Int(xPosition)
        }
        
        // FOR POSITION Y
        var y: Int
        if squareIndex <= (squareCount / 2){
            y = Int(yPosition)
        }else{
            y = Int(-yPosition)
        }
        
        return (x: x, y: y)
    }
    
    
    
    
    func getSquarePosition(squareCount: Int, squareIndex: Int) -> CGPoint{
        
        // for 6
        let divident = CGFloat(1.0) / CGFloat(squareCount)     // 0.333
        
        let numberOfColumnDividedBySquareCount = self.size.width * divident // half of the self.width
        let numberOfColumn = CGFloat(squareCount) * 0.5  // 2
        let numberOfColumnMinusOne = numberOfColumn - 1.0
        
        let initialPositionX = -(numberOfColumnDividedBySquareCount * numberOfColumnMinusOne)
        
        var columnIndexPosition = Int()
        if squareIndex%(squareCount/2) != 0{
            columnIndexPosition = squareIndex%(squareCount/2)
        }else{
            columnIndexPosition = squareCount/2
        }
        
        let additionalPosition = (CGFloat(columnIndexPosition - 1) *  (squareSize?.width)!)
        let x = initialPositionX + additionalPosition
        
        
        
        // FOR POSITION Y
        var y = Int((squareSize?.height)! * 0.5)
        if !(squareIndex <= (squareCount / 2)){
            y = -y
        }
        
        return CGPoint(x: x, y: CGFloat(y))
    }
    
    
    func setSquareSize(squareCount: Int) -> CGSize{
        
        let halfOfTheSquare = CGFloat(squareCount) / 2.0
        let divident = CGFloat(1.0) / halfOfTheSquare
        let dimension = self.size.width * divident
        return CGSize(width: dimension, height: dimension)
    }
    
    
    func removeSquare(toBeRemoveID: Int, toBeRemoveFromArray: [Int]) -> [Int]{
        var newArray = [Int]()
        
        for number in toBeRemoveFromArray{
            if number != toBeRemoveID{
                newArray.append(number)
            }
        }
        
        return newArray
        
    }
    
    func getTexture(textureID: Int) -> SKTexture{
        
        switch textureID{
        case 0:
            return GameAsset.blueTexture!
        case 1:
            return GameAsset.greenTexture!
        case 2:
            return GameAsset.orangeTexture!
        case 3:
            return GameAsset.redTexture!
        case 4:
            return GameAsset.darkBlueTexture!
        case 5:
            return GameAsset.darkGreenTexture!
        case 6:
            return GameAsset.pinkTexture!
        case 7:
            return GameAsset.violetTexture!
        case 8:
            return GameAsset.whiteTexture!
        case 9:
            return GameAsset.yellowTexture!
            
        default:
            return GameAsset.blueTexture!
        }
        
    }
    
//    func getTexture(textureID: Int) -> SKTexture{
//
//        switch textureID{
//        case 0:
//            return MemoryGameAsset.blueTexture!
//        case 1:
//            return MemoryGameAsset.greenTexture!
//        case 2:
//            return MemoryGameAsset.orangeTexture!
//        case 3:
//            return MemoryGameAsset.redTexture!
//        case 4:
//            return MemoryGameAsset.darkBlueTexture!
//        case 5:
//            return MemoryGameAsset.darkGreenTexture!
//        case 6:
//            return MemoryGameAsset.pinkTexture!
//        case 7:
//            return MemoryGameAsset.violetTexture!
//        case 8:
//            return MemoryGameAsset.whiteTexture!
//        case 9:
//            return MemoryGameAsset.yellowTexture!
//
//        default:
//            return MemoryGameAsset.blueTexture!
//        }
//
//    }
    
    
    
    

}






