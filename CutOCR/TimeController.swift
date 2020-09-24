//
//  TimeController.swift
//  Nipple
//
//  Created by Libre Gu on 2020/9/24.
//  Copyright © 2020 Libre. All rights reserved.
//

import Cocoa

class TimeController: NSViewController {

    @IBOutlet weak var txtFieldCurrentTimestamp: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func setInit() {
        setCurrentTimestamp()
    }
    
    private func setCurrentTimestamp() {
        let timeStamp = Int(Date().timeIntervalSince1970)
        txtFieldCurrentTimestamp.stringValue = String(timeStamp)
    }
}
