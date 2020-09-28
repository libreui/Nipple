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
    @IBOutlet weak var txtFieldTimestamp: NSTextField!
    @IBOutlet weak var txtFieldDate: NSTextField!
    @IBOutlet weak var txtFieldDateInput: NSTextField!
    @IBOutlet weak var txtFieldTimestampOutput: NSTextField!
    @IBOutlet weak var btnCopyCurrentTS: NSButton!
    @IBOutlet weak var btnChangeToDate: NSButton!
    @IBOutlet weak var btnChangeToTimestamp: NSButton!
    
    var currentTimestamp : String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func setInit() {
        setCurrentTimestamp()
    }
    
    private func setCurrentTimestamp() {
        let timeStamp = Int(Date().timeIntervalSince1970)
        currentTimestamp = String(timeStamp)
        txtFieldCurrentTimestamp.stringValue = currentTimestamp
        txtFieldTimestamp.stringValue = currentTimestamp
        
        //设置当前时间
        let dateformatter =  DateFormatter()
        //自定义日期格式
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        txtFieldDateInput.stringValue = dateformatter.string(from: Date())
        
    }
    @IBAction func onChangeToTimestampClicked(_ sender: NSButton) {
        let timpstampStr = stringToTimeStamp(stringTime: txtFieldDateInput.stringValue)
        txtFieldTimestampOutput.stringValue = timpstampStr
    }
    @IBAction func onChangeToDateClieked(_ sender: NSButton) {
        let timestampStr = txtFieldTimestamp.stringValue
        txtFieldDate.stringValue = getDateFormatString(timeStamp: timestampStr)
    }
    @IBAction func onCopyCurrentTSCliented(_ sender: NSButton) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects([currentTimestamp as NSString])
    }
}

//MARK: - 自定义函数部分
extension TimeController {
    func getDateFormatString(timeStamp:String) ->String{

        let  interval:TimeInterval=TimeInterval.init(timeStamp)!
        let date = Date(timeIntervalSince1970: interval)
        let dateformatter =  DateFormatter()

        //自定义日期格式
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateformatter.string(from: date)
    }
    //字符串转时间戳
    func stringToTimeStamp(stringTime:String)->String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: stringTime)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        return String(dateSt)
    }
}
