//
//  LowerScene.swift
//  Color Memory
//
//  Created by Harry Lingad on 22/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import SpriteKitEasingSwift


protocol RearrangingProtocol {
    func startRearranging()
    
}

class LowerScene: SKScene, TimerNodeProtocol{

    
    
    
    var statsNode: StatsNode?
    var timerNode: TimerNode?
    var pauseNode: PauseNode?
    var refreshNode: RefreshNode?
    var rearrangingDelegate: RearrangingProtocol?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        // Initialize lower view
        LowerViewDimension.initializeLowerViewDimension(nodeSize: size)
        
        pauseNode = PauseNode(size: LowerViewDimension.pauseNodeSize!)
        pauseNode?.position = LowerViewDimension.pauseNodeIntPosition!
        //pauseNode?.position = LowerViewDimension.pauseNodePosition!
        pauseNode?.anchorPoint = CGPoint(x: 0, y: 1)
        
        refreshNode = RefreshNode(size: LowerViewDimension.refreshNodeSize!)
        refreshNode?.position = LowerViewDimension.refreshNodeIntPosition!
        refreshNode?.anchorPoint = CGPoint(x: 0, y: 1)
        
        pauseNode = PauseNode(size: LowerViewDimension.pauseNodeSize!)
        pauseNode?.position = LowerViewDimension.pauseNodeIntPosition!
        pauseNode?.anchorPoint = CGPoint(x: 0, y: 1)

        
        timerNode = TimerNode(size: LowerViewDimension.timerNodeSize!, time: 6)
        //timerNode?.position = LowerViewDimension.timerNodeIntPosition!
        timerNode?.position = LowerViewDimension.timerNodePosition!
        timerNode?.anchorPoint = CGPoint(x: 0, y: 0.5)
        timerNode?.timerProtocol = self
        
        self.addChild(timerNode!)
        self.addChild(pauseNode!)
        self.addChild(refreshNode!)
        
        
        
    }
    
    //MARK: - REFRESHNODE
    func showRefreshNode(){
        EasingMovement.moveNode(originalNode: refreshNode!, newPosition: LowerViewDimension.refreshNodePosition!, completion: {})
    }
    
    
    func showPauseNode(){
        EasingMovement.moveNode(originalNode: pauseNode!, newPosition: LowerViewDimension.pauseNodePosition!, completion: {})
    }
    
    //MARK: - TIMERNODEProtocol delegate
    func hideMemorizingTimer(){
        EasingMovement.moveNode(originalNode: timerNode!, newPosition: LowerViewDimension.timerNodeIntPosition!, completion: {
            
            self.rearrangingDelegate?.startRearranging()
            //self.showMemorizingTimer()
        })
    }
    
    func showMemorizingTimer(){
        timerNode?.time = 31
        timerNode?.timerValueNode?.text = "\(30)"
        timerNode?.color = CMColor.cmColorLightGreen()
        showRefreshNode()
        showPauseNode()
        EasingMovement.moveNode(originalNode: timerNode!, newPosition: LowerViewDimension.timerNodePosition!, completion: {
            self.timerNode?.startCountingInRearranging()
        })
    }
    

    

    

    
    
    
    
    // OVERRIDE METHOD
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        if (pauseNode?.contains(touch.location(in: self)))! {
            pauseNode?.pressed()
        }else if (refreshNode?.contains(touch.location(in: self)))! {
            refreshNode?.pressed()
        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        if (pauseNode?.contains(touch.location(in: self)))! {
            pauseNode?.unPressed()
        }else if (refreshNode?.contains(touch.location(in: self)))! {
            refreshNode?.unPressed()
        }
    }
    
    
    
    
    
}

