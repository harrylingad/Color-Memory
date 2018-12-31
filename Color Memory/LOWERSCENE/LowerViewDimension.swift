//
//  LowerViewDimension.swift
//  Color Memory
//
//  Created by Harry Lingad on 22/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import UIKit

class LowerViewDimension{
    
    static var timerNodePosition: CGPoint?
    static var timerNodeIntPosition: CGPoint?
    static var timerNodeSize: CGSize?
    
    static var pauseNodePosition: CGPoint?
    static var pauseNodeIntPosition: CGPoint?
    static var pauseNodeSize: CGSize?
    
    static var refreshNodePosition: CGPoint?
    static var refreshNodeIntPosition: CGPoint?
    static var refreshNodeSize: CGSize?
    
    static var ySpace: CGFloat?
    
    
    static func initializeLowerViewDimension(nodeSize: CGSize){
        
        
        ySpace = LowerViewDimension.getYSpace(nodeSize: nodeSize)
        
        timerNodeSize = LowerViewDimension.timerNodeSize(nodeSize: nodeSize)
        pauseNodeSize = LowerViewDimension.pauseNodeSize(nodeSize: nodeSize)
        refreshNodeSize = LowerViewDimension.refreshNodeSize(nodeSize: nodeSize)
        
        
        
        timerNodePosition = LowerViewDimension.timerNodePosition(nodeSize: nodeSize)
        timerNodeIntPosition = LowerViewDimension.timerNodeIntPosition(nodeSize: nodeSize)
        
        pauseNodePosition = LowerViewDimension.pauseNodePosition(nodeSize: nodeSize)
        pauseNodeIntPosition = LowerViewDimension.pauseNodeIntPosition(nodeSize: nodeSize)
        
        
        
        refreshNodePosition = LowerViewDimension.refreshNodePosition(nodeSize: nodeSize)
        refreshNodeIntPosition = LowerViewDimension.refreshNodeIntPosition(nodeSize: nodeSize)
        
        
    }
    
    
    static func getYSpace(nodeSize: CGSize) -> CGFloat{
        let allSpace = (nodeSize.height * 0.4)
        return allSpace / 3
    }
    
    
    //MARK: - SCORE NODE
    static func timerNodeIntPosition(nodeSize: CGSize) -> CGPoint{
        let initialXPosition = (2 * LowerViewDimension.ySpace!) + (LowerViewDimension.pauseNodeSize?.width)!
        return CGPoint(x: initialXPosition, y: -((timerNodeSize?.height)! + LowerViewDimension.ySpace!))
    }
    
    static func timerNodePosition(nodeSize: CGSize) -> CGPoint{
        
        let initialXPosition = (2 * LowerViewDimension.ySpace!) + (LowerViewDimension.pauseNodeSize?.width)!
        return CGPoint(x: initialXPosition, y: 0)
    }
    
    static func timerNodeSize(nodeSize: CGSize) -> CGSize{
        let dimension = nodeSize.height - (2 * LowerViewDimension.ySpace!)
        return CGSize(width: dimension, height: dimension)
    }
    
    
    //MARK: - PAUSE NODE
    static func pauseNodeIntPosition(nodeSize: CGSize) -> CGPoint{
        
        let initialYPosition = (nodeSize.height * 0.5) - LowerViewDimension.ySpace!
        
        
        return CGPoint(x: -((LowerViewDimension.pauseNodeSize?.width)! + LowerViewDimension.ySpace!), y: initialYPosition)
    }
    
    static func pauseNodePosition(nodeSize: CGSize) -> CGPoint{
      
        let initialYPosition = (nodeSize.height * 0.5) - LowerViewDimension.ySpace!
        return CGPoint(x: LowerViewDimension.ySpace!, y: initialYPosition)
    }
    
    static func pauseNodeSize(nodeSize: CGSize) -> CGSize{
        let toBeMinus = (3 * LowerViewDimension.ySpace!) + (LowerViewDimension.timerNodeSize?.width)!
        let squareWidth = nodeSize.width - toBeMinus
        return CGSize(width: squareWidth, height: nodeSize.height * 0.3)
    }
    
    
    //MARK: - REFRESH NODE
    static func refreshNodeIntPosition(nodeSize: CGSize) -> CGPoint{
        
        let toBeMinusSpace = (2 * LowerViewDimension.ySpace!) + (LowerViewDimension.pauseNodeSize?.height)!
        let initialYPosition = (nodeSize.height * 0.5) - toBeMinusSpace
        
        return CGPoint(x: -((LowerViewDimension.refreshNodeSize?.width)! + LowerViewDimension.ySpace!), y: initialYPosition)
        
    }
    
    static func refreshNodePosition(nodeSize: CGSize) -> CGPoint{
        
        let toBeMinusSpace = (2 * LowerViewDimension.ySpace!) + (LowerViewDimension.pauseNodeSize?.height)!
        let initialYPosition = (nodeSize.height * 0.5) - toBeMinusSpace
        
        return CGPoint(x: LowerViewDimension.ySpace!, y: initialYPosition)
        
    }
    
    static func refreshNodeSize(nodeSize: CGSize) -> CGSize{
        let toBeMinus = (3 * LowerViewDimension.ySpace!) + (LowerViewDimension.timerNodeSize?.width)!
        let squareWidth = nodeSize.width - toBeMinus
        return CGSize(width: squareWidth, height: nodeSize.height * 0.3)
    }
    
    
    
    
}

