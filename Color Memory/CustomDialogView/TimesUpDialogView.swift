//
//  TimesUpView.swift
//  Color Memory
//
//  Created by Harry C. Lingad on 12/6/19.
//  Copyright © 2019 Harry Lingad. All rights reserved.
//

import UIKit

class TimesUpDialogView: UIView {
    
    @IBOutlet var timesUpDialogView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("TimesUpDialogView", owner: self, options: nil)
        addSubview(timesUpDialogView)
        timesUpDialogView.frame = self.bounds
        timesUpDialogView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

