//
//  GameAsset.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 02/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit

class GameAsset{
    
    static var explosionFrames:[SKTexture]?
    static var hideSquareFrames:[SKTexture]?
    
    static var blueTexture: SKTexture?
    static var redTexture: SKTexture?
    static var greenTexture: SKTexture?
    static var orangeTexture: SKTexture?
    static var darkBlueTexture: SKTexture?
    static var darkGreenTexture: SKTexture?
    static var pinkTexture: SKTexture?
    static var violetTexture: SKTexture?
    static var whiteTexture: SKTexture?
    static var yellowTexture: SKTexture?
    
    static var tobeAnswerNodes: [SquareNode]?
    
    static var tobeAnswerNode1: SquareNode?
    static var tobeAnswerNode2: SquareNode?
    static var tobeAnswerNode3: SquareNode?
    static var tobeAnswerNode4: SquareNode?
    
    static var submitButtonNode: SKSpriteNode?
    
    static var hideNode1: SKSpriteNode?
    static var hideNode2: SKSpriteNode?
    static var hideNode3: SKSpriteNode?
    static var hideNode4: SKSpriteNode?
    
    
    static var countDownTimerGroup: InstructionLabelNode?
    static var memorizeInLN: SKLabelNode?
    static var countdownTimerLN: SKLabelNode?
    

    
    
    //MARK: INITIALIZATION CODE
    static func initializeFrames(){
        var frames:[SKTexture]? = []
        let explosionAtlas = SKTextureAtlas(named: "Explosion")
        for index in 1 ... 10{
            let textureName = "explosion_\(index)"
            let texture = explosionAtlas.textureNamed(textureName)
            frames?.append(texture)
        }
        GameAsset.explosionFrames = frames
        
        var squareframes:[SKTexture]? = []
        let hideAtlas = SKTextureAtlas(named: "Hide")
        for index in 1 ... 10{
            let textureName = "hide_\(index)"
            let texture = hideAtlas.textureNamed(textureName)
            squareframes?.append(texture)
        }
        GameAsset.hideSquareFrames = squareframes
        
        
    }
    
    static func initializeTexture(){
        
        blueTexture = SKTexture(imageNamed: "blue.jpg")
        redTexture = SKTexture(imageNamed: "red.jpg")
        greenTexture = SKTexture(imageNamed: "green.jpg")
        orangeTexture = SKTexture(imageNamed: "orange.jpg")
        darkBlueTexture = SKTexture(imageNamed: "dark_blue.png")
        darkGreenTexture = SKTexture(imageNamed: "dark_green.png")
        pinkTexture = SKTexture(imageNamed: "pink.png")
        violetTexture = SKTexture(imageNamed: "violet.png")
        whiteTexture = SKTexture(imageNamed: "white.png")
        yellowTexture = SKTexture(imageNamed: "yellow.png")
        
    }
    
    // MARK: - ONGOING
    static func initializeToBeAnswerSquareNode2(size: CGSize, referenceNode: LevelOneSquare, squareCount: Int){
        
        let divident = CGFloat(1.0) / CGFloat(squareCount)
        let toBeAddedIn = referenceNode.size.width * divident
        
        tobeAnswerNodes = [SquareNode]()
        
        let halfHeight = size.height * 0.5
        let halfHeightReferenceNode = referenceNode.size.height * 0.5
        let initialPositionY = halfHeight - halfHeightReferenceNode
        
        
        let positionX = (size.width * 0.5) - ((referenceNode.size.width) * 0.5)
        let finalPositionX = positionX + toBeAddedIn
        
        let halfCount = Int(CGFloat(squareCount) * 0.5)
        
        var i = 1
        while i <= squareCount{
            
            // SOLVING FOR X POSITION
            var x = finalPositionX
            let columnNumber = i%halfCount
            if columnNumber == 0{
                x = finalPositionX + (CGFloat(halfCount - 1) * (referenceNode.squareSize?.width)!)
            }else{
                x = finalPositionX + (CGFloat(columnNumber - 1) * (referenceNode.squareSize?.width)!)
            }
            
            // SOLVING FOR Y POSITION
            var y = initialPositionY
            let rowNumber = i/halfCount
            
            if (rowNumber > 0) && (i != halfCount){
                y = initialPositionY - (referenceNode.squareSize?.height)!
            }
            
            let answerNode = SquareNode(texture: getTextureByIndex(index: i - 1), size: referenceNode.squareSize!, isActive: false, finalPosition: CGPoint(x: x, y: y), id: i - 1)
            
                tobeAnswerNodes?.append(answerNode)
            
            i += 1
          
        }
    }
    
    static func initializeSubmitButton(size: CGSize){
         
        submitButtonNode = SKSpriteNode()
        submitButtonNode?.color = UIColor.white
        submitButtonNode?.size = CGSize(width: size.width * 0.6, height: size.height * 0.05)
        submitButtonNode?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        
        let submitLabelNode = SKLabelNode(fontNamed:"Avenir-Light")
        submitLabelNode.text = "Submit"
        submitLabelNode.fontSize = ((submitButtonNode?.size.height)! * 0.5)
        submitLabelNode.fontColor = UIColor.black
        submitLabelNode.position = CGPoint(x: 0, y: -(submitButtonNode?.size.height)! * 0.2)
        
        submitButtonNode?.addChild(submitLabelNode)
    }
    
    // MARK: - ONGOING
   
    
//    static func initializeHideSquareNode(){
    
        // ROW 1
//        GameAsset.hideNode1 = SKSpriteNode(color: UIColor.clear, size: (GameAsset.toBeMemorizeNode1?.size)!)
//        GameAsset.hideNode1?.position = (GameAsset.toBeMemorizeNode1?.position)!
//        
//        // ROW 2
//        GameAsset.hideNode2 = SKSpriteNode(color: UIColor.clear, size: (GameAsset.toBeMemorizeNode2?.size)!)
//        GameAsset.hideNode2?.position = (GameAsset.toBeMemorizeNode2?.position)!
//        
//        // ROW 3
//        GameAsset.hideNode3 = SKSpriteNode(color: UIColor.clear, size: (GameAsset.toBeMemorizeNode3?.size)!)
//        GameAsset.hideNode3?.position = (GameAsset.toBeMemorizeNode3?.position)!
//        
//        // ROW 4
//        GameAsset.hideNode4 = SKSpriteNode(color: UIColor.clear, size: (GameAsset.toBeMemorizeNode4?.size)!)
//        GameAsset.hideNode4?.position = (GameAsset.toBeMemorizeNode4?.position)!
        
//    }
    
    
    
    static func initializeCountdownNodes(size: CGSize){
        
        countDownTimerGroup = InstructionLabelNode(texture: nil, color: UIColor.clear, size: size)

    }
    
    // MARK: - ANSWERNODE FUNCTION
    
    static func getTextureByIndex(index: Int) -> SKTexture{
        
        switch index {
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
            return GameAsset.whiteTexture!
        }
    }
    
    
//    func getSquarePosition(squareCount: Int, squareIndex: Int) -> CGPoint{
//
//        // for 6
//        let divident = CGFloat(1.0) / CGFloat(squareCount)     // 0.333
//
//        let numberOfColumnDividedBySquareCount = self.size.width * divident // half of the self.width
//        let numberOfColumn = CGFloat(squareCount) * 0.5  // 2
//        let numberOfColumnMinusOne = numberOfColumn - 1.0
//
//        let initialPositionX = -(numberOfColumnDividedBySquareCount * numberOfColumnMinusOne)
//
//        var columnIndexPosition = Int()
//        if squareIndex%(squareCount/2) != 0{
//            columnIndexPosition = squareIndex%(squareCount/2)
//        }else{
//            columnIndexPosition = squareCount/2
//        }
//
//        let additionalPosition = (CGFloat(columnIndexPosition - 1) *  (squareSize?.width)!)
//        let x = initialPositionX + additionalPosition
//
//        print("x: ", x)
//
//
//        // FOR POSITION Y
//        var y = Int((squareSize?.height)! * 0.5)
//        if !(squareIndex <= (squareCount / 2)){
//            y = -y
//        }
//
//        return CGPoint(x: x, y: CGFloat(y))
//    }

}
