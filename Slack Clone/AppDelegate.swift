//
//  AppDelegate.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 08/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa
import Parse

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



   func applicationDidFinishLaunching(_ aNotification: Notification) {
      let configuration = ParseClientConfiguration { (confingThing: ParseMutableClientConfiguration) in
         confingThing.applicationId = "paser_gbvbahia_macios"
         //confingThing.clientKey = ""
         confingThing.server = "http://pasergbvbahia.herokuapp.com/parse"
      }
      Parse.initialize(with: configuration)
   }

   func applicationWillTerminate(_ aNotification: Notification) {
      // Insert code here to tear down your application
   }


}

