//
//  GameOverDialogView.swift
//  Color Memory
//
//  Created by Harry C. Lingad on 12/6/19.
//  Copyright © 2019 Harry Lingad. All rights reserved.
//

import UIKit

class GameOverDialogView: UIView {
    
    @IBOutlet var gameOverDialogView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("GameOverDialogView", owner: self, options: nil)
        addSubview(gameOverDialogView)
        gameOverDialogView.frame = self.bounds
        gameOverDialogView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
