//
//  MenuViewController.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 14/11/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import UIKit
import SimpleAlert
import SpriteKit
import SpriteKitEasingSwift

class MenuViewController: UIViewController {
    @IBOutlet weak var colorSquares: SKView!
    var scene:MenuScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scene = MenuScene(size: self.colorSquares.frame.size, score: 0, squareCount: setCountOfSquare(squareCount: 0))
        self.colorSquares.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToGameScreen(_ sender: Any) {

        self.scene?.continueRumbleSquare = false
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameScreen") as! GameScreenViewController
        newViewController.score = 0
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
