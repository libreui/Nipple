//
//  Defined.swift
//  CutOCR
//
//  Created by Libre on 2020/3/28.
//  Copyright © 2020 Libre. All rights reserved.
//

import Foundation

var BAIDU_APP_KEY: String {
    return getBDKey()
}
var BAIDU_SECRET_KEY : String {
    return getBDSecret()
}

let BD_KEY = "BD_KEY"
let BD_SECRET = "BD_SECRET"

func setBDConfig(key:String, secret:String) -> Bool {
    if (key.isEmpty || secret.isEmpty) {
        return false
    }
    UserDefaults.standard.setValue(key, forKey: BD_KEY)
    UserDefaults.standard.setValue(secret, forKey: BD_SECRET)
    return true
}

func getBDKey() -> String {
    return UserDefaults.standard.string(forKey: BD_KEY) ?? ""
}
func getBDSecret() -> String {
    return UserDefaults.standard.string(forKey: BD_SECRET) ?? ""
}
