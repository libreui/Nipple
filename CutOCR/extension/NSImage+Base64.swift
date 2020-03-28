//
//  NSImage+Base64.swift
//  CutOCR
//
//  Created by Libre on 2020/3/28.
//  Copyright © 2020 Libre. All rights reserved.
//

import AppKit

extension NSImage {
    func base64String() -> String? {
        guard
            let bits = self.representations.first as? NSBitmapImageRep,
            let data = bits.representation(using: .png, properties: [:])
        else {
            return nil
        }

//        return "data:image/jpeg;base64,\(data.base64EncodedString())"
        return data.base64EncodedString()
    }
}
