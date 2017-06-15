//
//  ChatViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 14/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa
import Parse

class ChatViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
   
   @IBOutlet weak var titleChannelLabel: NSTextField!
   @IBOutlet weak var descripChannelLabel: NSTextField!
   @IBOutlet weak var tableView: NSTableView!
   @IBOutlet weak var messageTextField: NSTextField!
   
   var channel : PFObject?
   var chats : [PFObject] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self
   }
   
   @IBAction func sendClicked(_ sender: Any) {
      let chat = PFObject(className: "Chat")
      chat["message"] = messageTextField.stringValue
      chat["user"] = PFUser.current()
      chat["channel"] = channel
      chat.saveInBackground { (success: Bool, error: Error?) in
         if (success) {
            self.messageTextField.stringValue = ""
            self.getChats()
         } else {
            print("Error")
         }
      }
   }
   
   func updateChannel(channel: PFObject) {
      self.channel = channel
      getChats()
      if let title = channel["title"] as? String {
         titleChannelLabel.stringValue = "#\(title)"
         messageTextField.placeholderString = "Message #\(title)"
      }
      if let desc = channel["descrip"] as? String {
         descripChannelLabel.stringValue = desc
      }
   }
   
   func getChats() {
      if channel != nil {
         let query = PFQuery(className: "Chat")
         query.whereKey("channel", equalTo: channel!)
         query.addAscendingOrder("createdAt")
         query.findObjectsInBackground { (chats: [PFObject]?, error: Error?) in
            if error == nil {
               if chats != nil {
                  self.chats = chats!;
                  self.tableView.reloadData()
               }
            }
         }
      }
   }
   
   func numberOfRows(in tableView: NSTableView) -> Int {
      return chats.count
   }
   
   func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
      if let cell = tableView.make(withIdentifier: "chatCell", owner: nil) as? NSTableCellView {
         let chat = chats[row]
         if let message = chat["message"] as? String {
            cell.textField?.stringValue = message
         }
         return cell
      }
      return nil
   }
}
