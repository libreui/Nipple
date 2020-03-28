//
//  ViewController.swift
//  CutOCR
//
//  Created by Libre on 2020/3/26.
//  Copyright © 2020 Libre. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imgBox: NSImageView!
    @IBOutlet weak var txtBox: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func viewWillAppear() {
        view.window?.minSize = NSSize(width: 900, height: 600)
    }
    
    func setOCR() {
        view.window?.level = .floating
        txtBox.stringValue = "正在扫描中......"
        imgBox.image = NSImage(pasteboard: NSPasteboard.general)
        
        // 发起网络识别
        HttpClient.getOCR(imgBase64: imgBox.image?.base64String() ?? ""){
            json in
            
            let model = OCRBasicModel.deserialize(from: json)
            
            if (model?.words_result_num ?? 0 > 0) {
                self.txtBox.stringValue = ""
                model?.words_result?.forEach({ item in
                    self.txtBox.stringValue += "\r\n\r\n"
                    self.txtBox.stringValue += item.words ?? ""
                })
            } else {
                self.txtBox.stringValue = "没有解析道任何内容。"
            }
        }
        
    }
    
    override func viewDidDisappear() {
        print("控制器关闭")
    }

}

