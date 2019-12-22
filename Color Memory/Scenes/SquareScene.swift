
//  SquareScene.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 24/10/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SpriteKitEasingSwift



protocol SquareProtocol{
    func showDialog(isCorrect: Bool)
}

protocol ShowNodeProtocol{
    func showNodes()
    func hideUpperSceneNodes()
}



class SquareScene: SKScene{
 

    var explosionFrames:[SKTexture]?
    var hideSquareFrames:[SKTexture]?
    var titleLabel: SKLabelNode?
    
    var squareProtocolDelegate: SquareProtocol?
    var showNodesDelegate: ShowNodeProtocol?
    
    var score: Int?
    var squareCount: Int?
    var levelOne: LevelOneSquare?
    
    var answerID: String = ""
    var originalLevelID: String?
    
    var allToBeAnswerNode: MemorySquareObject?
    var answerNodePoints: [CGPoint]?
    
    var sqaureSize: CGFloat?
    
    var columnSquarePosition2: CGFloat?
    var rowSquarePosition2: CGFloat?
    
    var stillDragging: Bool = false
    var shouldNodeReturn: Bool = false
    
    var countDownLNGroup: InstructionLabelNode?
    
    var counter = 0
    var rearramgingCounter = 30
    var counterTimer: Timer?
    var counterStartValue = 3
    var rumbleCount = 4                      // number how many time the group of square will be rearrange
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(size: CGSize, score: Int, squareCount: Int) {
        super.init(size: size)
        self.backgroundColor = CMColor.cmColorBlack()
        self.score = score
        
        self.squareCount = squareCount //squareCount
        GameAsset.initializeTexture()
        GameAsset.initializeCountdownNodes(size: self.size)
        
        initializeToBeAnswerSquareNode()
    }
    
    //MARK: - INITIALIZE
    func initializeToBeAnswerSquareNode(){
        
        allToBeAnswerNode = MemorySquareObject(size: size, squareCount: self.squareCount!)
        for answerNode in (allToBeAnswerNode?.squares)!{
            self.addChild(answerNode)
        }
        originalLevelID = allToBeAnswerNode?.levelId
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
        
        self.setAnswerID(squares: (allToBeAnswerNode?.squares)!)
        
    }
    
    func dragNode(node: SquareNode, location: CGPoint){
        node.position.x = location.x
        node.position.y = location.y
        stillDragging = true
        node.isActive = true
    }
    
    func checkToExchangePosition(node: SquareNode){
        if node.isActive{
            for toBeAnswerNode in (allToBeAnswerNode?.squares)!{
                if (toBeAnswerNode.frame).contains((node.position)) && (toBeAnswerNode != node){
                    EasingMovement.exchangePosition(originalNodePosition: (node.origPosition), originalNode: node, toBeExchagePosition: (toBeAnswerNode.origPosition), toBeExchangeNode: toBeAnswerNode, completion: {
                        self.setAnswerID(squares: (self.allToBeAnswerNode?.squares)!)
                    })
                    shouldNodeReturn = true
                }
            }
            if !shouldNodeReturn{
                EasingMovement.returnLocation(node: node, completion: {
                    self.setAnswerID(squares: (self.allToBeAnswerNode?.squares)!)
                })
            }
            shouldNodeReturn =  false
        }
    }
    
    //MARK: CHECK THE ANSWER OF THE USER BEFORE CHECKING
    func setAnswerID(squares: [SquareNode]){
        answerID = ""
        
        for point in answerNodePoints!{
            for square in (allToBeAnswerNode?.squares)!{
                if square.position == point{
                    answerID = answerID + "\(square.id)"
                }
            }
        }
    }
    
    //MARK: CHECKING THE ANSWER OF THE USER
    func checkTheUserAnswer(){
        print("answerID: ", answerID)
        print("originalLevelID: ", originalLevelID ?? "")
        if answerID == originalLevelID{
            self.squareProtocolDelegate?.showDialog(isCorrect: true)
        }else{
            self.squareProtocolDelegate?.showDialog(isCorrect: false)
        }
    }
    
    func rumbleSquare(){
        
        allToBeAnswerNode?.generateNewID(originalID: (allToBeAnswerNode?.levelId)!, squareCount: squareCount!, completion: {newID in
            
            if answerNodePoints != nil{
                answerNodePoints?.removeAll()
            }else{
                answerNodePoints = [CGPoint]()
            }
            
            for positionIndex in (allToBeAnswerNode?.squares)!{
                answerNodePoints?.append(positionIndex.position)
            }
            
            for square in (allToBeAnswerNode?.squares)!{
                
                let ind0 = square.id
                let indexToMoveBySquareID = newID.index(of: ind0)
                
                
                if self.allToBeAnswerNode?.squares?.index(of: square) == ((self.allToBeAnswerNode?.squares?.count)! - 1){
                    EasingMovement.moveNodeWithCompletion(originalNode: square, newPosition: answerNodePoints![indexToMoveBySquareID!], completion: {
                        
                        var newNodes = [SquareNode]()
                        for id in newID{
                            newNodes.append(self.getSquareNodeByID(id: id)!)
                        }
                        
                        self.allToBeAnswerNode?.squares = newNodes
                        
                        if self.rumbleCount > 0{
                            self.rumbleSquare()
                        }
                        
                        self.rumbleCount = self.rumbleCount - 1
                    })
                }else{
                    EasingMovement.moveNode(originalNode: square, newPosition: answerNodePoints![indexToMoveBySquareID!])
                }
    
            }
            if self.rumbleCount <= 1{
                showNodesDelegate?.showNodes()
            }
            
            print("levelID: ", allToBeAnswerNode?.levelId ?? "")
        })
        
    }

    func getSquareNodeByID(id: Int) -> SquareNode?{
        for square in (allToBeAnswerNode?.squares)!{
            if square.id == id{
                return square
            }
        }
        
        return nil
    }
    
    
    //MARK: - OVERRIDE FUNCTIONS
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for tobeAnswerNode in (allToBeAnswerNode?.squares)!{
            checkToExchangePosition(node: tobeAnswerNode)
        }
        
        stillDragging = false
        
        for tobeAnswerNode in (allToBeAnswerNode?.squares)!{
            tobeAnswerNode.isActive = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            // Use for dragging the SquareNode
            for toBeAnswerNode in (allToBeAnswerNode?.squares)!{
                if (toBeAnswerNode.contains(location)) {
                    if !stillDragging || (toBeAnswerNode.isActive){
                        dragNode(node: toBeAnswerNode, location: location)
                    }
                }
            }
            
        }
        
    }
    
    
    func scaleSquare(node: SKSpriteNode){
        
        for square in (levelOne?.squares)!{
            square.run(SKEase.scale(easeFunction: .curveTypeElastic, easeType: .easeTypeOut, time: 1, from: 1, to: 1))
            square.zPosition = -1
        }
        
        node.run(SKEase.scale(easeFunction: .curveTypeElastic, easeType: .easeTypeOut, time: 1, from: 1, to: 1.2))
        node.zPosition = 1
    }
    
    
    func hideSquare(node: SKSpriteNode){
        node.run(SKAction.animate(with: hideSquareFrames!, timePerFrame: 0.05, resize: false, restore: false), completion: {
            //self.moveAllNodeDown()
        })
    }
    
    
    //MARK: - TIMER FUNCTION
    
    func startCountingInArranging(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerRearranging), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimerRearranging(){
        if rearramgingCounter <= 0{
            if counterTimer != nil {
                counterTimer?.invalidate()
                counterTimer = nil
            }
            
            self.squareProtocolDelegate?.showDialog(isCorrect: false)
            countDownLNGroup?.memorizeInLN?.text = ""
            
        }else{
            rearramgingCounter -= 1
            countDownLNGroup?.memorizeInLN?.text = "Arrange in \(rearramgingCounter)s..."
        }
    }
}




//MARK: - Next Level
extension SquareScene{
    
    func replaceAllSquares(){
        for square in allToBeAnswerNode?.squares ?? [SquareNode](){
            let nextX = (self.view?.frame.width ?? 0) + square.position.x
            let newPosition = CGPoint(x: nextX, y: square.position.y)
            EasingMovement.moveNode(originalNode: square, newPosition: newPosition , completion:{

                print("square index: ",  self.allToBeAnswerNode?.squares?.index(of: square) ?? 99)
                if self.allToBeAnswerNode?.squares?.index(of: square) == 0{
                    self.removeAllChildren()
                    self.rumbleCount = 4
                    self.initializeToBeAnswerSquareNode()
                }
            })
        }
    }
    
    func temporarilyHideUpperSceneNodes(){
        self.showNodesDelegate?.hideUpperSceneNodes()
    }
    
    
    
}

