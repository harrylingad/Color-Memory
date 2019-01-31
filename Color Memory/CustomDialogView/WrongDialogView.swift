//
//  WrongDialogView.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 06/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import UIKit

class WrongDialogView: UIView {
    
    @IBOutlet var wrongDialogView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("WrongDialogView", owner: self, options: nil)
        addSubview(wrongDialogView)
        wrongDialogView.frame = self.bounds
        wrongDialogView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

