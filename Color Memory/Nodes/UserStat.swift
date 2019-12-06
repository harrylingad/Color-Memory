//
//  UserStat.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 16/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import Foundation


class UserStat{
    
    var levelNode: LevelNode?
    var scoreNode: ScoreNode?
    
    var level: Int?
    var section: Int?
    var score: Int?
    
    init(levelNode: LevelNode, scoreNode: ScoreNode){
        
        self.levelNode = levelNode
        self.scoreNode = scoreNode
        
        self.level = 0
        self.section = 0
        self.score = 0
    }
    
    init(){
        
        self.levelNode = LevelNode()
        self.scoreNode = ScoreNode()
        
        self.level = 0
        self.section = 0
        self.score = 0
    }
    
    init(levelNode: LevelNode, scoreNode: ScoreNode, level: Int, section: Int, score: Int){
        
        self.levelNode = levelNode
        self.scoreNode = scoreNode
        
        self.level = level
        self.section = section
        self.score = score
    }
    
    
    func setUserStats(score: Int){
        self.scoreNode?.setScore(score: score)
    }
    
    
    
    
}
