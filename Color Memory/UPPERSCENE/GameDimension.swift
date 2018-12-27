//
//  GameDimension.swift
//  Color Memory
//
//  Created by Harry Lingad on 17/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import UIKit

class GameDimension{
    
    
    //MARK: - SCORE NODE
    static func scoreNodeDimension(nodeSize: CGSize) -> CGPoint{

        let statsNodeWidth = GameDimension.statsNodeSize(nodeSize: nodeSize)
        let levelNodeWidth = GameDimension.levelNodeSize(nodeSize: nodeSize)

        let totalWidthOfComponent = statsNodeWidth.width + (levelNodeWidth.width * 2)

        let spaceWidth = nodeSize.width - totalWidthOfComponent

        let spaceWidthDividedByFour = spaceWidth / 4

        let initialXPosition = (statsNodeWidth.width + levelNodeWidth.width) + (spaceWidthDividedByFour * 3)

        return CGPoint(x: initialXPosition, y: 0)
    }

    static func scoreNodeSize(nodeSize: CGSize) -> CGSize{
        return CGSize(width: nodeSize.height * 0.5, height: nodeSize.height * 0.5)
    }
    
    
    
    //MARK: - LEVEL NODE
    
    static func levelNodeDimension(nodeSize: CGSize) -> CGPoint{
        
        let statsNodeWidth = GameDimension.statsNodeSize(nodeSize: nodeSize)
        let levelNodeWidth = GameDimension.levelNodeSize(nodeSize: nodeSize)
        
        let totalWidthOfComponent = statsNodeWidth.width + (levelNodeWidth.width * 2)
        
        let spaceWidth = nodeSize.width - totalWidthOfComponent
        
        let spaceWidthDividedByFour = spaceWidth / 4
        
        let initialXPosition = statsNodeWidth.width + (spaceWidthDividedByFour * 2)
        
        return CGPoint(x: initialXPosition, y: 0)
    }
    
    static func levelNodeSize(nodeSize: CGSize) -> CGSize{
        return CGSize(width: nodeSize.height * 0.5, height: nodeSize.height * 0.5)
    }
    
    
    //================================================================
    
    
    //MARK: - STATS NODE
    static func statsNodeSize(nodeSize: CGSize) -> CGSize{
        return CGSize(width: nodeSize.width * 0.5, height: nodeSize.height * 0.5)
    }
    
    static func statsNodeDimension(nodeSize: CGSize) -> CGPoint{
        
        let statsNodeWidth = GameDimension.statsNodeSize(nodeSize: nodeSize)
        let levelNodeWidth = GameDimension.levelNodeSize(nodeSize: nodeSize)
        
        let totalWidthOfComponent = statsNodeWidth.width + (levelNodeWidth.width * 2)
        
        let spaceWidth = nodeSize.width - totalWidthOfComponent
        
        let spaceWidthDividedByFour = spaceWidth / 4

        return CGPoint(x: spaceWidthDividedByFour, y: 0)
    }
    
    
    //MARK: - SHUFFLE LABEL NODE
    
    static func shuffleLabelPosition(nodeSize: CGSize) -> CGPoint{
        return CGPoint(x: 0, y: nodeSize.height * 0.1)
    }
    
    
    
    
    //MARK: - LIFE SQUARE
    
    static func lifeSquareSize(nodeSize: CGSize) -> CGSize{
         let widthHeight = (nodeSize.width / 5)
        return CGSize(width: widthHeight, height: widthHeight)
    }
    
    static func lifeSquareDimension(nodeSize: CGSize, squareSize: CGSize) -> (firstDim: CGPoint, middleDim: CGPoint, lastDim: CGPoint){
        
        let fourSpaceTobeDivided = nodeSize.width - (squareSize.width * 3)
        let fourSpaceDivideByFour = fourSpaceTobeDivided / 4
        let firsSquareXPosition = fourSpaceDivideByFour
        let middleSquareXPosition = squareSize.width + (2 * firsSquareXPosition)
        let lastSquareXPosition = (2 * squareSize.width) + (3 * fourSpaceDivideByFour)
        
        
        let firstDimension = CGPoint(x: firsSquareXPosition, y: 0)
        let middleDimension = CGPoint(x: middleSquareXPosition, y: 0)
        let lastDimension = CGPoint(x: lastSquareXPosition, y: 0)
        
        return (firstDimension, middleDimension, lastDimension)
        
    }
    
    
    
    
    
    
    
}
