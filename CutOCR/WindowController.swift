//
//  WindowController.swift
//  CutOCR
//
//  Created by Libre on 2020/3/27.
//  Copyright © 2020 Libre. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        shouldCascadeWindows = true
    }
}
