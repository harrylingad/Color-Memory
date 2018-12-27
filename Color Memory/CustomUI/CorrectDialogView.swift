//
//  CorrectDialogView.swift
//  AlzeimerMonster
//
//  Created by Harry Lingad on 06/12/2018.
//  Copyright © 2018 Harry Lingad. All rights reserved.
//

import UIKit

class CorrectDialogView: UIView {

    @IBOutlet var correctDialogView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("CorrectDialogView", owner: self, options: nil)
        addSubview(correctDialogView)
        correctDialogView.frame = self.bounds
        correctDialogView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
