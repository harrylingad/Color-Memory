//
//  ViewController.swift
//  Color Memory
//
//  Created by Harry Lingad on 15/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import UIKit
import SpriteKit
import SpriteKitEasingSwift
import SimpleAlert

class GameScreenViewController: UIViewController, SquareProtocol {
    
    @IBOutlet weak var statsView: SKView!
    var upperScene: UpperMenuScene?
    
    
    
    
    @IBOutlet weak var lowerSceneView: SKView!
    var lowerScene: LowerScene?
    
    @IBOutlet weak var sceneView: SKView!
    var scene:SquareScene?
    var score: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.upperScene = UpperMenuScene(size: self.statsView.frame.size)
        self.statsView.presentScene(upperScene)
        
        score = 0
        self.scene = SquareScene(size: self.sceneView.frame.size, score: self.score!, squareCount: setCountOfSquare(squareCount: score!))
        self.scene?.squareProtocolDelegate = self
        self.sceneView.presentScene(scene)
        
        
        self.lowerScene = LowerScene(size: self.lowerSceneView.frame.size)
        self.lowerSceneView.presentScene(lowerScene)
        
    }
    
    
    
    
    func showDialog(isCorrect: Bool) {
        if isCorrect{
            print("CORRECT ANSWER")
            self.showCorrectDialog()
        }else{
            self.showWrongDialog()
            print("WRONG ANSWER")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showCorrectDialog(){
        
//        let correctDialogView = CorrectDialogView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
//
//        let alert = AlertController(view: correctDialogView, style: .alert)
//
//        let action = AlertAction(title: "Continue", style: .ok) { action in
//            self.goToNextMemoryScreen()
//        }
//
//        alert.addAction(action)
//        action.button.frame.size.height = 50
//        action.button.backgroundColor = UIColor.blue
//        action.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
//        action.button.setTitleColor(UIColor.red, for: .normal)
//
//        present(alert, animated: true, completion: nil)
        
        
    }
    
    func showWrongDialog(){
        
//        let wrongDialogView = WrongDialogView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
//        let alert = AlertController(view: wrongDialogView, style: .alert)
//        let action = AlertAction(title: "Try Again", style: .ok) { action in
//            self.tryAgainScreen()
//        }
//
//        alert.addAction(action)
//        action.button.frame.size.height = 50
//        action.button.backgroundColor = UIColor.blue
//        action.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
//        action.button.setTitleColor(UIColor.red, for: .normal)
//
//        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    func goToNextMemoryScreen(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameScreen") as! GameScreenViewController
        newViewController.score = score! + 1
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    func tryAgainScreen(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameScreen") as! GameScreenViewController
        newViewController.score = score!
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    
    
    func setCountOfSquare(squareCount: Int) -> Int{
        
        if squareCount > 2{
            return 6
        }else if squareCount > 5{
            return 8
        }else if squareCount > 8{
            return 10
        }else{
            return 4
        }
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
}

