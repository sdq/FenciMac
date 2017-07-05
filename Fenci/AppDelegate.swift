//
//  AppDelegate.swift
//  Fenci
//
//  Created by sdq on 9/2/16.
//  Copyright © 2016 sdq. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            for window in sender.windows {
                window.makeKeyAndOrderFront(self)
            }
        }
        return true
    }
    
    @IBAction func reopen(_ sender: NSMenuItem) {
        for window in NSApplication.shared().windows {
            window.makeKeyAndOrderFront(self)
        }
    }

    @IBAction func about(_ sender: NSMenuItem) {
        if let checkURL = URL(string: "https://github.com/sdq/FenciMac") {
            if NSWorkspace.shared().open(checkURL) {
                print("url successfully opened")
            }
        }
    }
}

