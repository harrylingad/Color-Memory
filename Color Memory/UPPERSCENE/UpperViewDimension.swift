//
//  GameDimension.swift
//  Color Memory
//
//  Created by Harry Lingad on 17/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import UIKit

class UpperViewDimension{
    
    static var scoreNodePosition: CGPoint?
    static var scoreNodeIntPosition: CGPoint?
    static var scoreNodeSize: CGSize?
    
    static var levelNodePosition: CGPoint?
    static var levelNodeIntPosition: CGPoint?
    static var levelNodeSize: CGSize?
    
    static var statsNodeSize: CGSize?
    static var statsNodePosition: CGPoint?
    static var statsNodeIntPosition: CGPoint?
    
    static var shuffleLabelPosition: CGPoint?
    
    static var lifeSquareSize: CGSize?
    static var lifeSquarePosition: CGPoint?
    
    static var xSpace: CGFloat?
    
    static func initializeUpperViewDimension(nodeSize: CGSize){
        
        
        
        statsNodeSize = UpperViewDimension.statsNodeSize(nodeSize: nodeSize)
        levelNodeSize = UpperViewDimension.levelNodeSize(nodeSize: nodeSize)
        scoreNodeSize = UpperViewDimension.scoreNodeSize(nodeSize: nodeSize)
        
        xSpace = xInitialSpace(nodeSize: nodeSize)
        
        statsNodeIntPosition = UpperViewDimension.statsNodeIntPosition(nodeSize: nodeSize)
        statsNodePosition = UpperViewDimension.statsNodePosition(nodeSize: nodeSize)
        
        
        scoreNodePosition = UpperViewDimension.scoreNodePosition(nodeSize: nodeSize)
        scoreNodeIntPosition = UpperViewDimension.scoreNodeIntPosition(nodeSize: nodeSize)
        
        
        levelNodePosition = UpperViewDimension.levelNodePosition(nodeSize: nodeSize)
        levelNodeIntPosition = UpperViewDimension.levelNodeIntPosition(nodeSize: nodeSize)
        
        shuffleLabelPosition = UpperViewDimension.shuffleLabelPosition(nodeSize: nodeSize)
        
        lifeSquareSize = UpperViewDimension.lifeSquareSize(nodeSize: nodeSize)
        
        
        
    }
    
    static func xInitialSpace(nodeSize: CGSize) -> CGFloat{
        
        let totalWidthOfComponent = (UpperViewDimension.statsNodeSize?.width)! + ((UpperViewDimension.levelNodeSize?.width)! * 2)
        let spaceWidth = nodeSize.width - totalWidthOfComponent
        return spaceWidth / 4
    }
    
    
    //MARK: - SCORE NODE
    
    static func scoreNodeIntPosition(nodeSize: CGSize) -> CGPoint{
        let initialXPosition = ((UpperViewDimension.statsNodeSize?.width)! + (UpperViewDimension.levelNodeSize?.width)!) + (UpperViewDimension.xSpace! * 3)
        let initialYPosition = (UpperViewDimension.scoreNodeSize?.height)! * 1.5
        
        return CGPoint(x: initialXPosition, y: initialYPosition)
    }
    
    static func scoreNodePosition(nodeSize: CGSize) -> CGPoint{
        let initialXPosition = ((UpperViewDimension.statsNodeSize?.width)! + (UpperViewDimension.levelNodeSize?.width)!) + (UpperViewDimension.xSpace! * 3)
        return CGPoint(x: initialXPosition, y: 0)
    }

    static func scoreNodeSize(nodeSize: CGSize) -> CGSize{
        return CGSize(width: nodeSize.height * 0.5, height: nodeSize.height * 0.5)
    }
    
    
    
    //MARK: - LEVEL NODE
    static func levelNodeIntPosition(nodeSize: CGSize) -> CGPoint{
        let initialXPosition = (UpperViewDimension.statsNodeSize?.width)! + (UpperViewDimension.xSpace! * 2)
        let initialYPosition = (UpperViewDimension.levelNodeSize?.height)! * 1.5
        
        return CGPoint(x: initialXPosition, y: initialYPosition)
    }
    
    static func levelNodePosition(nodeSize: CGSize) -> CGPoint{
        let initialXPosition = (UpperViewDimension.statsNodeSize?.width)! + (UpperViewDimension.xSpace! * 2)
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
    
    static func statsNodeIntPosition(nodeSize: CGSize) -> CGPoint{
        let initialXPosition = (UpperViewDimension.statsNodeSize?.width)! + UpperViewDimension.xSpace!
        return CGPoint(x: -initialXPosition , y: 0)
    }
    
    static func statsNodePosition(nodeSize: CGSize) -> CGPoint{
        return CGPoint(x: UpperViewDimension.xSpace! , y: 0)
    }
    
    
    //MARK: - SHUFFLE LABEL NODE
    
    static func shuffleLabelPosition(nodeSize: CGSize) -> CGPoint{
        return CGPoint(x: 0, y: nodeSize.height * 0.1)
    }
    
    //MARK: - LIFE SQUARE
    
    static func lifeSquareSize(nodeSize: CGSize) -> CGSize{
        
        let width = (nodeSize.width / 5)
        let height = (nodeSize.width / 8)
        return CGSize(width: width, height: height)
    }
    
    static func lifeSquarePosition(nodeSize: CGSize, squareSize: CGSize) -> (firstDim: CGPoint, middleDim: CGPoint, lastDim: CGPoint){
        
        let fourSpaceTobeDivided = nodeSize.width - (squareSize.width * 3)
        let fourSpaceDivideByFour = fourSpaceTobeDivided / 4
        let firsSquareXPosition = fourSpaceDivideByFour
        let middleSquareXPosition = squareSize.width + (2 * firsSquareXPosition)
        let lastSquareXPosition = (2 * squareSize.width) + (3 * fourSpaceDivideByFour)
        
        
        let firstPosition = CGPoint(x: firsSquareXPosition, y: 0)
        let middlePosition = CGPoint(x: middleSquareXPosition, y: 0)
        let lastPosition = CGPoint(x: lastSquareXPosition, y: 0)
        
        return (firstPosition, middlePosition, lastPosition)
        
    }
    
    
    
    
    
    
    
}
