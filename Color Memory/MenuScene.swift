//
//  MenuScene.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 08/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import SpriteKitEasingSwift




class MenuScene: SKScene{
    
    
    
    var squareCount: Int?
    var levelOne: LevelOneSquare?
    
    var originalLevelID: String?
    
    var allToBeAnswerNode: MenuSquareObject?
    var answerNodePoints: [CGPoint]?
    var continueRumbleSquare = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(size: CGSize, score: Int, squareCount: Int) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        
        self.squareCount = 4//squareCount
        
        GameAsset.initializeTexture()
        GameAsset.initializeCountdownNodes(size: self.size)
        
        initializeToBeAnswerSquareNode()
        
//        rumbleSquare()
        
        
    }
    
    
    
    
    //MARK: - INITIALIZE
    
    func initializeToBeAnswerSquareNode(){
        
        allToBeAnswerNode = MenuSquareObject(size: size, squareCount: self.squareCount!)
        for answerNode in (allToBeAnswerNode?.squares)!{
            self.addChild(answerNode)
        }
    }
    
    
    //MARK: - OTHER FUNCTIONS
    
    func showAnsweringNodes(){
        
        for answerNode in (allToBeAnswerNode?.squares)!{
            EasingMovement.answeringNodeMoveUp(skSpriteNode: answerNode, completion:{
                
                if ((self.allToBeAnswerNode?.squares?.index(of: answerNode))! + 1) == self.allToBeAnswerNode?.squares?.count{
                    return self.saveOriginalPosition()
                }else{
                    return nil
                }
                
            })
        }
    }
    
    
    func saveOriginalPosition(){
        
        answerNodePoints = [CGPoint]()
        for toBeAnswerNode in (allToBeAnswerNode?.squares)!{
            // SAVE THE ORIGINAL POSITION OF SQUARE. USED IN MOVING THE SQUARE IF IT WILL EXCHANGE POSITION OR RETURN TO POSITION
            toBeAnswerNode.origPosition = (toBeAnswerNode.position)
            // SAVE THE ORIGINAL ANSWERID. THIS IS USED TO COMPARE THE ANSWER AND MEMORIZE SQUARE. IF THE USER IS CORRECT OR NOT
            answerNodePoints?.append(toBeAnswerNode.position)
            
        }
    }

    

    
    func checkToExchangePosition(node: SquareNode){
        if node.isActive{
            for toBeAnswerNode in (allToBeAnswerNode?.squares)!{
                if (toBeAnswerNode.frame).contains((node.position)) && (toBeAnswerNode != node){
                    EasingMovement.exchangePosition(originalNodePosition: (node.origPosition), originalNode: node, toBeExchagePosition: (toBeAnswerNode.origPosition), toBeExchangeNode: toBeAnswerNode, completion: {
                    })
                }
            }
        }
    }
    
    
    
    

    
    
    
    
//    func rumbleSquare(){
//
//        allToBeAnswerNode?.generateNewID(originalID: (allToBeAnswerNode?.levelId)!, squareCount: squareCount!, completion: {newID in
//
//            if answerNodePoints != nil{
//                answerNodePoints?.removeAll()
//            }else{
//                answerNodePoints = [CGPoint]()
//            }
//
//            for positionIndex in (allToBeAnswerNode?.squares)!{
//                answerNodePoints?.append(positionIndex.position)
//            }
//
//
//            for square in (allToBeAnswerNode?.squares)!{
//
//                let ind0 = square.id
//                let indexToMoveBySquareID = newID.index(of: ind0)
//
//
//                if self.allToBeAnswerNode?.squares?.index(of: square) == ((self.allToBeAnswerNode?.squares?.count)! - 1){
//                    EasingMovement.moveNodeWithCompletion(originalNode: square, newPosition: answerNodePoints![indexToMoveBySquareID!], completion: {
//
//                        var newNodes = [SquareNode]()
//                        for id in newID{
//                            newNodes.append(self.getSquareNodeByID(id: id)!)
//                        }
//
//                        self.allToBeAnswerNode?.squares = newNodes
//
//                        if self.continueRumbleSquare{
//                            self.rumbleSquare()
//                        }
//                    })
//                }else{
//                    EasingMovement.moveNode(originalNode: square, newPosition: answerNodePoints![indexToMoveBySquareID!])
//                }
//
//
//            }
//
//        })
//    }
    
    
    
    
   
    
    
    
    func getSquareNodeByID(id: Int) -> SquareNode?{
        
        for square in (allToBeAnswerNode?.squares)!{
            if square.id == id{
                return square
            }
        }
        
        return nil
    }
    
    

    
    

    

    

    
    

    
    

    
    

    
    
    


    
    
}
