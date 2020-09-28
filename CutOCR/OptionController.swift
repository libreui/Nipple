//
//  OptionController.swift
//  Nipple
//
//  Created by Libre Gu on 2020/9/28.
//  Copyright © 2020 Libre. All rights reserved.
//

import Cocoa

class OptionController: NSViewController {

    
    @IBOutlet weak var txtFieldBDAppKey: NSTextField!
    @IBOutlet weak var txtFieldBDSecretKey: NSTextField!
    @IBOutlet weak var btnSave: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.window?.level = .floating
        
        txtFieldBDSecretKey.stringValue = BAIDU_SECRET_KEY
        txtFieldBDAppKey.stringValue = BAIDU_APP_KEY
    }
    
    func setInit() {
        view.window?.level = .floating
    }

    @IBAction func onSave(_ sender: NSButton) {
        let key = txtFieldBDAppKey.stringValue
        let secret = txtFieldBDSecretKey.stringValue
        setBDConfig(key: key, secret: secret)
        initAccessToken()
    }
    
    //TODO 初始化百度Token
    func initAccessToken() {
        HttpClient().getAccessToken {
            jsonStr in
            Cache.TOKEN = AccessTokenModel.deserialize(from: jsonStr)?.access_token ?? ""
        }
    }
    
}
