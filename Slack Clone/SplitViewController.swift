//
//  SplitViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 13/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
   
   override func viewDidAppear() {
      if let channelsVC = splitViewItems[0].viewController as? ChannelsViewController {
         if let chatVC = splitViewItems[1].viewController as? ChatViewController {
            channelsVC.chatVC = chatVC
         }
      }
   }
}
