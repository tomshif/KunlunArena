//
//  AppDelegate.swift
//  KunlunArena
//
//  Created by Tom Shiflet on 12/3/19.
//  Copyright © 2019 LCS Game Design. All rights reserved.
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
    
    // Make the application close completely when closing the window
    func applicationShouldTerminateAfterLastWindowClosed (_ theApplication: NSApplication) -> Bool { return true }
    
}
