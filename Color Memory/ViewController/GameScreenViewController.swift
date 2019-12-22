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

class GameScreenViewController: UIViewController, SquareProtocol, RearrangingProtocol, ShowNodeProtocol, NoMoreTimeProtocol, PauseNodeProtocol {
    
    
   
    @IBOutlet weak var navigationView: UIView!
    
    @IBOutlet weak var statsView: SKView!
    
    
    
    @IBOutlet weak var lowerSceneView: SKView!
    
    var upperScene:  UpperMenuScene?
    var scene: SquareScene?
    var lowerScene: LowerScene?
    
    @IBOutlet weak var sceneView: SKView!
    
    var score: Int = 0
    var level: Int = 0
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.navigationView.backgroundColor = CMColor.cmColorBlack()
        
        let defaults = UserDefaults.standard
        score = defaults.integer(forKey: "score")
//        score = 0
        
        self.upperScene = UpperMenuScene(size: self.statsView.frame.size)
        self.upperScene?.scoreNode?.setScore(score: score )
        self.upperScene?.levelNode?.setLevel(levelNode: setCountOfSquare(score: score).1, score: score)
        self.statsView.presentScene(upperScene)
        
        self.scene = SquareScene(size: self.sceneView.frame.size, score: self.score, squareCount: setCountOfSquare(score: score).0)
        self.scene?.squareProtocolDelegate = self
        self.scene?.showNodesDelegate = self
        self.scene?.isUserInteractionEnabled = false
        self.sceneView.presentScene(scene)
        
        self.lowerScene = LowerScene(size: self.lowerSceneView.frame.size)
        self.lowerScene?.rearrangingDelegate = self
        self.lowerScene?.timerNode?.noMoreTimeDelegate = self
        self.lowerScene?.pauseNode?.pauseNodeDelegate = self
        
        self.lowerSceneView.presentScene(lowerScene)
        
       
    }
    
    //MARK: - SQUARE PROTOCOL : SHOW DIALOG DEPENDING TO THE USER'S ANSWER
    func showDialog(isCorrect: Bool) {
        if isCorrect{
            print("CORRECT ANSWER")
            self.showCorrectDialog()
        }else{
            
            let numberOfLife = self.upperScene?.statsNode?.numberOfLife ?? 3
            
            if numberOfLife <= 0{
                self.showGameOverDialog()
            }else{
                self.showWrongAnswerDialog()
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateScore(){
        self.score = score + 1
        self.level = level + 1
        
        self.upperScene?.scoreNode?.setScore(score: score )
        self.upperScene?.levelNode?.setLevel(levelNode: setCountOfSquare(score: score).1, score: score)
        defaults.set(self.score, forKey: "score")
    }
    
//    func goToNextMemoryScreen(){
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameScreen") as! GameScreenViewController
//        newViewController.score = score + 1
//        newViewController.level = level + 1
//
////        let defaults = UserDefaults.standard
//        defaults.set(newViewController.score, forKey: "score")
//
//        self.present(newViewController, animated: true, completion: nil)
//
//    }

    // FIRST(0) RETURN VALUE IS SQUARECOUNT, SECOND(1) IS LEVEL
    func setCountOfSquare(score: Int) -> (Int, Int){
        if score > 2 && score < 6{
            return (6, 2)
        }else if score > 5 && score < 9{
            return (8, 3)
        }else if score > 8  && score < 12{
            return (10, 4)
        }else{
            return (4 , 1)
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //MARK: - ShowNodeProtocol
    func showNodes() {
        upperScene?.showStats()
        upperScene?.showLevel()
        upperScene?.showScore()
        lowerScene?.showLowerScene()
    }
    
    
    func hideUpperSceneNodes(){
        upperScene?.hideStats()
        upperScene?.hideLevel()
        upperScene?.hideScore()
        lowerScene?.hideLowerScene()
    }

    //MARK: - RearrangingProtocol
    func startRearranging() {
        scene?.rumbleSquare()
    }
    
    func submitAnswer() {
        scene?.checkTheUserAnswer()
    }
    
    func disableSquareNode() {
        scene?.isUserInteractionEnabled = false
    }
       
    func enableSquareNode() {
        scene?.isUserInteractionEnabled = true
    }
    
    func noMoreTime() {
        showTimesUpDialog()
    }

}

//MARK: - DIALOGs
extension GameScreenViewController{
    
    //PAUSE THE TIMER AND SHOW THE CORRECT ANSWER DIALOG
       func showCorrectDialog(){
        
           self.lowerScene?.timerNode?.clearRunningTimeForNextLevel()
           let correctDialogView = CorrectDialogView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
           let alert = AlertController(view: correctDialogView, style: .alert)

           let action = AlertAction(title: "Continue", style: .ok) { action in
            
            self.scene?.replaceAllSquares()
            self.scene?.temporarilyHideUpperSceneNodes()
            self.updateScore()
            //self.goToNextMemoryScreen()
           }

           alert.addAction(action)
           action.button.frame.size.height = 50
           action.button.backgroundColor = CMColor.cmColorBlue()
           action.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
           action.button.setTitleColor(UIColor.black, for: .normal)
           present(alert, animated: true, completion: nil)
           
       }
       
       
       func showWrongAnswerDialog(){

           let wrongDialogView = WrongDialogView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
           let alert = AlertController(view: wrongDialogView, style: .alert)
           let action = AlertAction(title: "Continue", style: .ok) { action in
               
            let numberOfLife = self.upperScene?.statsNode?.numberOfLife ?? 3
            
            if numberOfLife <= 0{
                //TODO: - GO BACK TO MAIN MENU
                self.upperScene?.statsNode?.numberOfLife = 3
                self.upperScene?.statsNode?.removeLife(numberOfLife: self.upperScene?.statsNode?.numberOfLife ?? 3)
            }else{
                self.upperScene?.statsNode?.removeLife(numberOfLife: self.upperScene?.statsNode?.numberOfLife ?? 3)
            }
           }

           alert.addAction(action)
           action.button.frame.size.height = 50
           action.button.backgroundColor = UIColor.blue
           action.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
           action.button.setTitleColor(UIColor.red, for: .normal)

           present(alert, animated: true, completion: nil)
       }
       
       
       func showTimesUpDialog(){
           
           let wrongDialogView = TimesUpDialogView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
           let alert = AlertController(view: wrongDialogView, style: .alert)
           let action = AlertAction(title: "Try Again", style: .ok) { action in
               self.tryAgainScreen()
           }

           alert.addAction(action)
           action.button.frame.size.height = 50
           action.button.backgroundColor = UIColor.blue
           action.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
           action.button.setTitleColor(UIColor.red, for: .normal)

           present(alert, animated: true, completion: nil)
       }
       
       func showPauseDialog(){
           
           let pauseDialogView = PauseDialogView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
           let alert = AlertController(view: pauseDialogView, style: .alert)
           let action = AlertAction(title: "Resume", style: .ok) { action in
               self.resumeGame()
           }
           
           alert.addAction(action)
           action.button.frame.size.height = 50
           action.button.backgroundColor = UIColor.blue
           action.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
           action.button.setTitleColor(UIColor.red, for: .normal)
           
           present(alert, animated: true, completion: nil)
       }
       
       func showGameOverDialog(){
           
           let pauseDialogView = GameOverDialogView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
           let alert = AlertController(view: pauseDialogView, style: .alert)
           let action = AlertAction(title: "Play Again", style: .ok) { action in
               self.tryAgainScreen()
           }
           
           alert.addAction(action)
           action.button.frame.size.height = 50
           action.button.backgroundColor = UIColor.blue
           action.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
           action.button.setTitleColor(UIColor.red, for: .normal)
           
           present(alert, animated: true, completion: nil)
       }
    

}


//MARK: - DIALOG BUTTON ACTION
extension GameScreenViewController{
    
    func tryAgainScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameScreen") as! GameScreenViewController
        newViewController.score = score
        self.present(newViewController, animated: true, completion: nil)
        
    }

    func pauseRearrangeTimer() {
        showPauseDialog()
        self.lowerScene?.timerNode?.pauseRearrangeTime()
    }
    
    func resumeGame(){
        self.lowerScene?.timerNode?.pauseRearrangeTime()
    }
    
}






//MARK: - DIALOG BUTTON ACTION
extension GameScreenViewController{
    func moveSquareScene(){
        
    }
}
