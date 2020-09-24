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
    var ctrl : ViewController?
    var timeCtrl : TimeController?

    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        initMenu()
        initStatusBarButtom()
        initAccessToken()
        
        win = storyboard.instantiateController(withIdentifier: "ocrWindow") as? NSWindowController
        timeWin = storyboard.instantiateController(withIdentifier: "timeWin") as? TimeWindowController
        ctrl = storyboard.instantiateController(withIdentifier: "viewCtrl") as? ViewController
        timeCtrl = storyboard.instantiateController(withIdentifier: "timeCtrl") as? TimeController
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
        cutItem.title = "OCR"
        
        let cutItemSubMenu = NSMenu(title: "OCR")
//        cutItemSubMenu.addItem(withTitle: "截图", action: #selector(AppDelegate.onCutClicked), keyEquivalent: "")
        cutItemSubMenu.addItem(withTitle: "识别...", action: #selector(AppDelegate.onCutClicked), keyEquivalent: "")
        
        cutItem.submenu = cutItemSubMenu
    
        statusBarMenu.addItem(cutItem)
        
        let timeItem = NSMenuItem(
            title: "Timestamp...",
            action: #selector(AppDelegate.onCapture),
            keyEquivalent: ""
        )
        statusBarMenu.addItem(timeItem)
    }
    
    //TODO 初始化百度Token
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
    
    //MARK: 截图
    @objc func onCapture() {
        timeWin?.showWindow(self)
        let vc = timeWin?.contentViewController as! TimeController
        vc.setInit()
    }
    
    private func openWin() -> ViewController {
        win?.showWindow(self)
        return win?.contentViewController as! ViewController
    }
    

}

