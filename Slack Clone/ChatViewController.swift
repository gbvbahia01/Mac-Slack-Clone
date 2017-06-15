//
//  ChatViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 14/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa
import Parse

class ChatViewController: NSViewController {

   @IBOutlet weak var titleChannelLabel: NSTextField!
   @IBOutlet weak var descripChannelLabel: NSTextField!
   @IBOutlet weak var tableView: NSTableView!
   @IBOutlet weak var messageTextField: NSTextField!
   
   var channel : PFObject?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
   @IBAction func sendClicked(_ sender: Any) {
   }
   
   func updateChannel(channel: PFObject) {
      self.channel = channel
      if let title = channel["title"] as? String {
         titleChannelLabel.stringValue = "#\(title)"
         messageTextField.placeholderString = "Message #\(title)"
      }
      if let desc = channel["descrip"] as? String {
         descripChannelLabel.stringValue = desc
      }
   }
}
