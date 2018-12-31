//
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

class SquareScene: SKScene{
    
    var explosionFrames:[SKTexture]?
    var hideSquareFrames:[SKTexture]?
    var titleLabel: SKLabelNode?
    
    var squareProtocolDelegate: SquareProtocol?
    
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
    var rumbleCount = 2                      // number how many time the group of square will be rearrange
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(size: CGSize, score: Int, squareCount: Int) {
        super.init(size: size)
        self.backgroundColor = CMColor.cmColorBlack()
        self.score = score
        
        self.squareCount = 4//squareCount
        
        
        
        GameAsset.initializeTexture()
        //        initializeToBeMemorizeSquareNode()
        //GameAsset.initializeToBeAnswerSquareNode2(size: self.size, referenceNode: levelOne!, squareCount: squareCount)
        //        GameAsset.initializeSubmitButton(size: self.size)
        GameAsset.initializeCountdownNodes(size: self.size)
        
        initializeFrames()
        initializeToBeAnswerSquareNode()
        
        
    }
    
    
    
    
    //MARK: - INITIALIZE
    
    func initializeFrames(){
        var frames:[SKTexture]? = []
        let explosionAtlas = SKTextureAtlas(named: "Explosion")
        for index in 1 ... 10{
            let textureName = "explosion_\(index)"
            let texture = explosionAtlas.textureNamed(textureName)
            frames?.append(texture)
        }
        self.explosionFrames = frames
        
        var squareframes:[SKTexture]? = []
        let hideAtlas = SKTextureAtlas(named: "Hide")
        for index in 1 ... 10{
            let textureName = "hide_\(index)"
            let texture = hideAtlas.textureNamed(textureName)
            squareframes?.append(texture)
        }
        self.hideSquareFrames = squareframes
        
    }
    
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
    
    
    
    func setAnswerID(squares: [SquareNode]){
        answerID = ""
        
        for point in answerNodePoints!{
            for square in (allToBeAnswerNode?.squares)!{
                if square.position == point{
                    answerID = answerID + "\(square.id)"
                }
            }
            
        }
        
        print("answerID: ", answerID)
        self.checkTheUserAnswer()
    }
    
    //MARK: CHECKING THE ANSWER OF THE USER
    
    func checkTheUserAnswer(){
        if answerID == originalLevelID{
            self.squareProtocolDelegate?.showDialog(isCorrect: true)
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
                startCountingInArranging()
            }
            
            print("levelID: ", allToBeAnswerNode?.levelId ?? "")
        })
        
        
        //        var positionArray = [CGPoint]()
        
        
        
        
    }
    
    
    
    
    //    func rumbleSquare(){
    //
    //        allToBeAnswerNode?.generateNewID(originalID: (allToBeAnswerNode?.levelId)!, squareCount: squareCount!, completion: {
    //
    //        })
    //
    //        allToBeAnswerNode?.generateNewID(originalID: (allToBeAnswerNode?.levelId)!, squareCount: squareCount!)
    //
    ////        var positionArray = [CGPoint]()
    //
    //        if answerNodePoints != nil{
    //            answerNodePoints?.removeAll()
    //        }else{
    //            answerNodePoints = [CGPoint]()
    //        }
    //
    //        for positionIndex in (allToBeAnswerNode?.squares)!{
    //            answerNodePoints?.append(positionIndex.position)
    //        }
    //
    //
    //        for square in (allToBeAnswerNode?.squares)!{
    //
    //            let ind0 = square.id
    //            let indexToMoveBySquareID = newID?.index(of: ind0)
    //
    //
    //            EasingMovement.moveNode(originalNode: square, newPosition: answerNodePoints![indexToMoveBySquareID!], completion: {
    //
    //            if self.allToBeAnswerNode?.squares?.index(of: square) == ((self.allToBeAnswerNode?.squares?.count)! - 1){
    //
    //                        var newNodes = [SquareNode]()
    //                        for id in newID!{
    //                            newNodes.append(self.getSquareNodeByID(id: id)!)
    //                        }
    //
    //                        self.allToBeAnswerNode?.squares = newNodes
    //
    //
    //                        if self.rumbleCount > 0{
    //                            self.rumbleSquare()
    //                        }
    //
    //                        self.rumbleCount = self.rumbleCount - 1
    //
    //
    //                }
    //
    //            })
    //
    //        }
    //        if self.rumbleCount <= 1{
    //            countDownLNGroup?.setToStart()
    //        }
    //
    //        print("levelID: ", allToBeAnswerNode?.levelId ?? "")
    //
    //
    //    }
    
    
    
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
        
        //        let touch = touches.first!
        //        if (submitButtonNode?.contains(touch.location(in: self)))! {
        //            submitButtonNode?.color = UIColor.white
        //            (submitButtonNode?.children[0] as? SKLabelNode)?.fontColor = UIColor.black
        //            self.checkTheUserAnswer()
        //        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        let touch = touches.first!
        
        
        //                if (submitButtonNode?.contains(touch.location(in: self)))! {
        //                    submitButtonNode?.color = UIColor.black
        //                    (submitButtonNode?.children[0] as? SKLabelNode)?.fontColor = UIColor.white
        //                }
        
    }
    
    override func didMove(to view: SKView) {
        counter = counterStartValue
        startCounting()
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
    
    
    
    func startCounting(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer(){
        
        if counter <= 0{
            if counterTimer != nil {
                counterTimer?.invalidate()
                counterTimer = nil
            }
            // FIRST LOAD STEP - 1 : HIDE THE MEMORIZE IN AND SECOND LABEL
            //            EasingMovement.hideTheCountdownLabelNode(scene: self, completion: {
            //                //  FIRST LOAD STEP - 2 :  USED IN SCALING THE MEMORIZE SQUARE NODE WHEN COVERING IT
            //                EasingMovement.scaleHideDownGroupNodeX(node: self.levelOne!, completion: {
            //                    //  FIRST LOAD STEP - 3 :  SHOW ANSWERING NODE
            //
            countDownLNGroup?.setToRearranging()
            
            self.rumbleSquare()
            //
            //                    //self.showAnsweringNodes()
            //                })
            //            })
            
        }else{
            counter -= 1
            
            countDownLNGroup?.memorizeInLN?.text = "Memorize in \(counter)s..."
        }
    }
    
    
}

