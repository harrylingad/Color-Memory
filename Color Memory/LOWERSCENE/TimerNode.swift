//
//  TimerNode.swift
//  Color Memory
//
//  Created by Harry Lingad on 22/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation

import SpriteKit


protocol TimerNodeProtocol{
    func hideMemorizingTimer()
}

class TimerNode: SKSpriteNode{
    
    var timerValueNode: SKLabelNode?
    var time: Int = 0
    var counterTimer: Timer?
    var timerProtocol: TimerNodeProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(texture: nil, color: UIColor.gray, size: CGSize(width: 0, height: 0))
    }
    
    
    init(size: CGSize, time: Int){
        
        super.init(texture: nil, color: CMColor.cmColorOrange(), size: size)
        
        self.time = time
        let timerLabelNode = SKLabelNode(fontNamed: "Avenir-Light")
        timerLabelNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        timerLabelNode.text = "TIMER"
        timerLabelNode.fontSize = ((size.width) * 0.25)
        timerLabelNode.fontColor = UIColor.black
        
        timerValueNode = SKLabelNode(fontNamed: "Avenir-Bold")
        timerValueNode?.position = CGPoint(x: self.size.width * 0.5, y: -self.size.height * 0.3)
        timerValueNode?.text = "\(String(describing: self.time))"
        timerValueNode?.fontSize = ((size.width) * 0.3)
        timerValueNode?.fontColor = UIColor.black
        
        self.addChild(timerLabelNode)
        self.addChild(timerValueNode!)
        
        startCountingInMemorizing()
    }
    
    
    //MARK: - MEMORIZING
    func setTimeMemorizing(time: Int){
        self.time = time
        if time > 5{
            self.timerValueNode?.text = "5"
        }else{
            self.timerValueNode?.text = "\(self.time)"
        }
    }
    
    func startCountingInMemorizing(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerMemorizing), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimerMemorizing(){
        
        if time <= 0{
            if counterTimer != nil {
                counterTimer?.invalidate()
                counterTimer = nil
            }
            timerProtocol?.hideMemorizingTimer()
        }else{
            time -= 1
            setTimeMemorizing(time: time)
        }
    }
    
    
    
    
    
    //MARK: - REARRANGING
    
    func startCountingInRearranging(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerRearranging), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimerRearranging(){
        
        if time <= 0{
            if counterTimer != nil {
                counterTimer?.invalidate()
                counterTimer = nil
            }
            //timerProtocol?.hideMemorizingTimer()
        }else{
            time -= 1
            setTimeRearranging(time: time)
        }
    }
    
    func setTimeRearranging(time: Int){
        self.time = time
        self.timerValueNode?.text = "\(self.time)"
    }
    
    
    
    
    
}

