//
//  PauseDialogView.swift
//  Color Memory
//
//  Created by Harry Lingad on 31/01/2019.
//  Copyright © 2019 Harry Lingad. All rights reserved.
//

import UIKit

class PauseDialogView: UIView {
    

    @IBOutlet var pauseDialogView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("PauseDialogView", owner: self, options: nil)
        addSubview(pauseDialogView)
        pauseDialogView.frame = self.bounds
        pauseDialogView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

