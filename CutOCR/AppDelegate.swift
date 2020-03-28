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
    var ctrl : ViewController?
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        initMenu()
        initStatusBarButtom()
        initAccessToken()
        
        win = storyboard.instantiateController(withIdentifier: "ocrWindow") as? NSWindowController
        ctrl = storyboard.instantiateController(withIdentifier: "viewCtrl") as? ViewController

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    private func initMenu() {
        menuCut.action = #selector(AppDelegate.onCutClicked)
    }

    private func initStatusBarButtom() {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(
            withLength: NSStatusItem.squareLength)
        statusBarItem.button?.title = "OCR"
        statusBarItem.button?.image = NSImage(named: "StatusBar")
        

        let statusBarMenu = NSMenu(title: "OCR")
        statusBarItem.menu = statusBarMenu

        let cutItem = NSMenuItem(
            title: "OCR...",
            action: #selector(AppDelegate.onCutClicked),
            keyEquivalent: "")
        statusBarMenu.addItem(cutItem)
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
    
    private func openWin() -> ViewController {
        win?.showWindow(self)
        return win?.contentViewController as! ViewController
    }
    

}

