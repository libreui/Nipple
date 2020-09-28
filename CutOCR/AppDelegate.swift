//
//  AppDelegate.swift
//  CutOCR
//
//  Created by Libre on 2020/3/26.
//  Copyright © 2020 Libre. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusBarItem: NSStatusItem!
    @IBOutlet weak var menuCut: NSMenuItem!
    
    let storyboard = NSStoryboard(name: "Main", bundle: nil)
    var win : NSWindowController?
    var timeWin : TimeWindowController?
    var optionWin : OptionWindowController?
    
    var ctrl : ViewController?
    var timeCtrl : TimeController?
    var optionCtrl : OptionController?

    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        initMenu()
        initStatusBarButtom()
        initAccessToken()
        
        win = storyboard.instantiateController(withIdentifier: "ocrWindow") as? NSWindowController
        timeWin = storyboard.instantiateController(withIdentifier: "timeWin") as? TimeWindowController
        optionWin = storyboard.instantiateController(withIdentifier: "optionWin") as? OptionWindowController
        
        ctrl = storyboard.instantiateController(withIdentifier: "viewCtrl") as? ViewController
        timeCtrl = storyboard.instantiateController(withIdentifier: "timeCtrl") as? TimeController
        optionCtrl = storyboard.instantiateController(withIdentifier: "optionCtrl") as? OptionController

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    private func initMenu() {
        menuCut.action = #selector(AppDelegate.onCutClicked)
    }

    //MARK: - 初始化菜单图标
    private func initStatusBarButtom() {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusBarItem.button?.title = "Nipple"
        statusBarItem.button?.image = NSImage(named: "StatusBar")
        

        let statusBarMenu = NSMenu(title: "Nipple")
        statusBarItem.menu = statusBarMenu

        let cutItem = NSMenuItem()
        cutItem.title = "OCR截图"
        cutItem.action = #selector(AppDelegate.onCutClicked)
        
//        let cutItemSubMenu = NSMenu(title: "OCR")
//        cutItemSubMenu.addItem(withTitle: "截图并识别", action: #selector(AppDelegate.onCaptureClieked), keyEquivalent: "")
//        cutItemSubMenu.addItem(withTitle: "识别...", action: #selector(AppDelegate.onCutClicked), keyEquivalent: "")
        
//        cutItem.submenu = cutItemSubMenu
    
        statusBarMenu.addItem(cutItem)
        
        let timeItem = NSMenuItem(
            title: "时间戳...",
            action: #selector(AppDelegate.onTimestampClicked),
            keyEquivalent: ""
        )
        statusBarMenu.addItem(timeItem)
        
        statusBarMenu.addItem(NSMenuItem.separator())
        
        let optionItem = NSMenuItem(
            title: "设置...",
            action: #selector(AppDelegate.onOptionClicked),
            keyEquivalent: ""
        )
        statusBarMenu.addItem(optionItem)
    }
    
    //MARK: 初始化百度Token
    func initAccessToken() {
        HttpClient().getAccessToken {
            jsonStr in
            Cache.TOKEN = AccessTokenModel.deserialize(from: jsonStr)?.access_token ?? ""
        }
    }

    @objc func onCutClicked() {
        print("cut clicked!")
        let vc = openWin()
        vc.setOCR()
    }
    
    //MARK: 时间戳
    @objc func onTimestampClicked() {
        timeWin?.showWindow(self)
        let vc = timeWin?.contentViewController as! TimeController
        vc.setInit()
    }
    
    //MARK: 截图
    @objc func onCaptureClicked() {
        
    }
    
    //MARK: 设置
    @objc func onOptionClicked() {
        optionWin?.showWindow(self)
        let vc = optionWin?.contentViewController as! OptionController
        vc.setInit()
    }
    
    private func openWin() -> ViewController {
        win?.showWindow(self)
        return win?.contentViewController as! ViewController
    }
    

}

