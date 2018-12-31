//
//  MemorySquareObject.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 25/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit
import GLKit
import GameplayKit


class MemorySquareObject{
    
    var squares: [SquareNode]?
    var levelId: String = ""
    var referenceIDArry = [Int]()
    
    init(size: CGSize, squareCount: Int){
        
        squares = [SquareNode]()
        
        // HALF SIZE OF SCREEN
        let halfSizeOfScreen = size.width * 0.5
        
        // HALF OF THE NUMBER OF SQUARE
        let halfCount = Int(CGFloat(squareCount) * 0.5)
        
        // VALUE TO DIVIDE TO GET ALL SQUARE
        let valueToDividedToGetAllSquareWith = halfCount + 2
        
        // THIS WILL BE USED TO GET THE WIDTH OF ONE SQUARE
        let oneDividedByValueToDividedToGetAllSquareWith = CGFloat(1.0) / CGFloat(valueToDividedToGetAllSquareWith)
        
        // GET THE WIDTH OF THE ONE SQUARE
        let widthOfOneSquare = size.width * oneDividedByValueToDividedToGetAllSquareWith
        
        // GET THE HALF WIDTH OF THE ONE SQUARE
        let halfWidthOfOneSquare = widthOfOneSquare * 0.5
        
        // VALUE TO MINUS TO THE halfSizeOfScreen to get the initialPositionX
        let valueToMinusToTheHalfSizeOfScreen = halfWidthOfOneSquare * CGFloat(halfCount)
        
        // VALUE TO MINUS TO THE halfSizeOfScreen to get the initialPositionX and width of the one square
        let valueToMinusToTheHalfSizeOfScreenAndhalfWidthOfOneSquare = valueToMinusToTheHalfSizeOfScreen - halfWidthOfOneSquare
        
        // VALUE OF INITIAL X POSITION
        let finalPositionX = halfSizeOfScreen - valueToMinusToTheHalfSizeOfScreenAndhalfWidthOfOneSquare
        
        
        let initialPositionY = (size.height * 0.5) + halfWidthOfOneSquare
        
        var index = 0
        var referenceIDArray = [Int]()
        while index < squareCount{
            referenceIDArray.append(index)
            index += 1
        }
        
        
        var i = 1
        while i <= squareCount{
            
            // SOLVING FOR X POSITION
            var x = finalPositionX
            let columnNumber = i%halfCount
            if columnNumber == 0{
                x = finalPositionX + (CGFloat(halfCount - 1) * widthOfOneSquare)
            }else{
                x = finalPositionX + (CGFloat(columnNumber - 1) * widthOfOneSquare)
            }
            
            // SOLVING FOR Y POSITION
            var y = initialPositionY
            let rowNumber = i/halfCount
            
            if (rowNumber > 0) && (i != halfCount){
                y = initialPositionY - widthOfOneSquare
            }
            
            
            // GENERATING NUMBER
            let randomNumberDistribution = GKRandomDistribution(lowestValue: 0, highestValue: referenceIDArray.count - 1)
            let squareIDIndex = randomNumberDistribution.nextInt()
            
            let idValue = referenceIDArray[squareIDIndex]
            
            referenceIDArray = removeSquare(toBeRemoveID: idValue, toBeRemoveFromArray: referenceIDArray)
            levelId = levelId + "\(idValue)"
            
            
            
            let answerNode = SquareNode(texture: getTextureByIndex(index: idValue), size: CGSize(width: widthOfOneSquare, height: widthOfOneSquare), isActive: false, finalPosition: CGPoint(x: x, y: y), id: idValue)
            
            squares?.append(answerNode)
            
            i += 1
            
        }
        
        
        print("LEVEL_ID: ", levelId)
        referenceIDArry = self.convertIdToInt(originalID: levelId)
    }
    
    
    func generateNewID(originalID: String, squareCount: Int, completion: (_ newID: [Int])-> Void) {
        var newID = [Int]()

        // USE TO GET THE VALUE BASED ON THE RAMDOM INDEX squareIDIndex
        var originalIDInteger = self.convertIdToInt(originalID: originalID)
        
        var randomNumberDistribution = GKRandomDistribution()
        var randomIndex = 0
        
        var i = 0
        while i < squareCount{
            randomNumberDistribution = GKRandomDistribution(lowestValue: 0, highestValue: originalIDInteger.count - 1)
            randomIndex = randomNumberDistribution.nextInt()
            
            
            // check if the element in referenceIDArray is equal to the new value (originalIDInteger[randomIndex]) to be set
            while originalIDInteger[randomIndex] == referenceIDArry[i]{
                randomNumberDistribution = GKRandomDistribution(lowestValue: 0, highestValue: originalIDInteger.count - 1)
                randomIndex = randomNumberDistribution.nextInt()
                
                if i == (referenceIDArry.count - 1){
                    if newID[0] == originalIDInteger[randomIndex]{
                        let temp = newID[1]
                        newID[1] = originalIDInteger[randomIndex]
                        originalIDInteger[randomIndex] = temp
                    }else{
                        let temp = newID[0]
                        newID[0] = originalIDInteger[randomIndex]
                        originalIDInteger[randomIndex] = temp
                    }
                }
            }
            let newValue = originalIDInteger[randomIndex]
            newID.append(newValue)
            
            originalIDInteger = removeSquare(toBeRemoveID: originalIDInteger[randomIndex], toBeRemoveFromArray: originalIDInteger)
            
            i += 1
        }
        self.levelId = self.convertIdToString(originalID: newID)
        referenceIDArry = newID
        
        completion(newID)
    }
    
    
    
    
    func convertIdToInt(originalID: String) -> [Int]{
        var idIntegerArray = [Int]()
        
        for num in originalID{
            let numberString = String(num)
            let integerNumber = Int(numberString)
            idIntegerArray.append(integerNumber!)
        }
        
        return idIntegerArray
    }
    
    func convertIdToString(originalID: [Int]) -> String{
        var idString = ""
        
        for num in originalID{
            idString = idString + "\(num)"
        }
        
        return idString
    }
    
    
    
    func getTextureByIndex(index: Int) -> SKTexture{
        
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
    
    
    
    
    func removeSquare(toBeRemoveID: Int, toBeRemoveFromArray: [Int]) -> [Int]{
        var newArray = [Int]()
        
        for number in toBeRemoveFromArray{
            if number != toBeRemoveID{
                newArray.append(number)
            }
        }
        
        return newArray
        
    }
    
    
    
    
}
