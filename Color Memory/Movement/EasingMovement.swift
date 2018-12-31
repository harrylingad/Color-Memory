//
//  SpriteKitEasingMovement.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 03/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation
import SpriteKit
import SpriteKitEasingSwift


class EasingMovement{
    
    static func moveAnswerNodeDown(skSpriteNode: SKSpriteNode, point: CGPoint){
        
        skSpriteNode.run(SKEase.move(easeFunction: .curveTypeQuintic,
                                     easeType: .easeTypeOut,
                                     time: 2,
                                     from: CGPoint(x: (skSpriteNode.position.x), y: (skSpriteNode.position.y)),
                                     to:CGPoint(x: point.x, y: point.y)))
    }
    
    
    
    static func answeringNodeMoveUp(skSpriteNode: SquareNode, completion: @escaping () -> Void?){

        skSpriteNode.run(SKEase.move(easeFunction: .curveTypeQuintic,
                                     easeType: .easeTypeOut,
                                     time: 1,
                                     from: skSpriteNode.position,
                                     to:skSpriteNode.finalPosition!), completion: {
                                        completion()
        })
    }
    
    static func answeringNodeMoveUpLayer2(skSpriteNode: SKSpriteNode, baseNode: SKSpriteNode, completion: @escaping () -> Void?){
        let newY = (baseNode.position.y) - (baseNode.size.height * 1.5)
        let toPosition = CGPoint(x: (skSpriteNode.position.x), y: newY)
        
        skSpriteNode.run(SKEase.move(easeFunction: .curveTypeQuintic,
                                     easeType: .easeTypeOut,
                                     time: 1,
                                     from: skSpriteNode.position,
                                     to:toPosition), completion: {
                                        completion()
        })
    }
    
    
    
    static func returnLocation(node: SquareNode, completion: @escaping ()-> Void){
        node.run(SKEase.move(easeFunction: .curveTypeQuintic,
                             easeType: .easeTypeOut,
                             time: 1,
                             from: node.position,
                             to: node.origPosition), completion: {
                                completion()
        })
    }
    
    
    static func moveNodeWithCompletion(originalNode: SquareNode, newPosition: CGPoint, completion: @escaping ()->Void){
        originalNode.run(SKEase.move(easeFunction: .curveTypeQuintic,
                                     easeType: .easeTypeOut,
                                     time: 3,
                                     from: originalNode.position,
                                     to: newPosition), completion: {
                                        originalNode.origPosition = newPosition
                                        completion()
        })
    }
    
    static func moveNode(originalNode: SquareNode, newPosition: CGPoint){
        originalNode.run(SKEase.move(easeFunction: .curveTypeQuintic,
                                     easeType: .easeTypeOut,
                                     time: 3,
                                     from: originalNode.position,
                                     to: newPosition), completion: {
                                        originalNode.origPosition = newPosition
        })
    }
    
    static func moveNode(originalNode: SKSpriteNode, newPosition: CGPoint, completion: @escaping ()->Void){
        originalNode.run(SKEase.move(easeFunction: .curveTypeQuintic,
                                     easeType: .easeTypeOut,
                                     time: 3,
                                     from: originalNode.position,
                                     to: newPosition), completion: {
                                        completion()
        })
    }
    
    
    static func moveNode2(squares: [SquareNode], newPositionArray: [CGPoint], newID: [Int], completion: @escaping ()->Void) -> [SKAction]{
        
        var actions = [SKAction]()
        
        for square in squares{
            let newAction = SKAction.run {
                let action = SKEase.move(easeFunction: .curveTypeQuartic, easeType: .easeTypeOut, time: 1, from: square.position, to: newPositionArray[newID.index(of: square.id)!])
                
                square.origPosition = newPositionArray[newID.index(of: square.id)!]
                square.run(action)
                
            }
            actions.append(newAction)
        }
        
        return [SKAction.group(actions)]
        
        
        
        
        
    }
    
    
    
    
    
    static func exchangePosition(originalNodePosition: CGPoint, originalNode: SquareNode, toBeExchagePosition: CGPoint, toBeExchangeNode: SquareNode, completion: @escaping ()->Void){
        
        originalNode.run(SKEase.move(easeFunction: .curveTypeQuintic,
                                     easeType: .easeTypeOut,
                                     time: 1,
                                     from: originalNode.position,
                                     to: toBeExchangeNode.position))
        
        toBeExchangeNode.run(SKEase.move(easeFunction: .curveTypeQuintic,
                                         easeType: .easeTypeOut,
                                         time: 1,
                                         from: toBeExchagePosition,
                                         to: originalNodePosition), completion: {
                                            completion()
        })
        
        originalNode.origPosition = toBeExchagePosition
        toBeExchangeNode.origPosition = originalNodePosition
        
    }
    
    
    //MARK: - SCALE AND HIDE THE MEMORIZING NODE
    // HIDE
    static func scaleHideDownGroupNodeX(node: SKSpriteNode, completion: @escaping () -> Void){
        node.run(SKAction.scaleX(to: 0.0, duration: 0.2), completion: {
            // HIDE ALL THE NODES IN THE SQUARE NODE CONTAINER
            for childNode in node.children{
                childNode.run(SKAction.hide())
            }
            node.texture = GameAsset.blueTexture
            
            
            EasingMovement.scaleHideUpGroupNodeX(node: node, completion: {
                completion()
            })
           
        })
    }
    
    static func scaleHideUpGroupNodeX(node: SKSpriteNode, completion: @escaping () -> Void){
        node.run(SKAction.scaleX(to: 1.0, duration: 0.2), completion: {
            
            completion()
            // TODO: TEMPORARY unhide again
            //EasingMovement.scaleUnHideDownGroupNodeX(node: node)
        })
    }
    
    // UNHIDE
    static func scaleUnHideDownGroupNodeX(node: SKSpriteNode, completion: @escaping ()-> Void){
        node.run(SKAction.scaleX(to: 0.0, duration: 0.2), completion: {
            for childNode in node.children{
                childNode.run(SKAction.unhide())
            }
            EasingMovement.scaleUnHideUpGroupNodeX(node: node, completion: {
                completion()
            })
           
        })
    }
    
    static func scaleUnHideUpGroupNodeX(node: SKSpriteNode, completion: @escaping () -> Void?){
        node.run(SKAction.scaleX(to: 1.0, duration: 0.2), completion:{
            completion()
        })
    }
    
    
    
    
    
    
    // How the MemorizeIn and CountdownTimer Label Node
    static func hideTheCountdownLabelNode(scene:  SKScene, completion: @escaping () -> Void){
        
        let newCountDownTimerPoint = CGPoint(x: (GameAsset.countDownTimerGroup?.position.x)! , y: -CGFloat((GameAsset.countDownTimerGroup?.size.height)!))
        GameAsset.countDownTimerGroup?.run(SKEase.move(easeFunction: .curveTypeQuintic,
                                                    easeType: .easeTypeOut,
                                                    time: 1,
                                                    from: (GameAsset.countDownTimerGroup?.position)!,
                                                    to: newCountDownTimerPoint), completion: {
                                                        completion()
        }) 
    }
    
    
    
    
}
