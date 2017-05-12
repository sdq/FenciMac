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

    @IBAction func about(_ sender: NSMenuItem) {
        if let checkURL = URL(string: "https://github.com/sdq/FenciMac") {
            if NSWorkspace.shared().open(checkURL) {
                print("url successfully opened")
            }
        }
    }

}

