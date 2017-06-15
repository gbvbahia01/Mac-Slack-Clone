//
//  ChatViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 14/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa
import Parse

class ChatViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, NSTextFieldDelegate {
   
   @IBOutlet weak var titleChannelLabel: NSTextField!
   @IBOutlet weak var descripChannelLabel: NSTextField!
   @IBOutlet weak var tableView: NSTableView!
   @IBOutlet weak var messageTextField: NSTextField!
   
   var channel : PFObject?
   var chats : [PFObject] = []
   var timer : Timer?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self
      messageTextField.delegate = self
   }
   override func viewWillAppear() {
      clearChat()
   }
   
   override func viewWillDisappear() {
      timer?.invalidate()
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
   
   func clearChat() {
      channel = nil
      chats = []
      tableView.reloadData()
      titleChannelLabel.stringValue = ""
      descripChannelLabel.stringValue = ""
      messageTextField.placeholderString = ""
      
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
      timer?.invalidate()
      timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
         print("Timer")
         self.getChats()
      }
   }
   
   func getChats() {
      if channel != nil {
         let query = PFQuery(className: "Chat")
         query.includeKey("user")
         query.whereKey("channel", equalTo: channel!)
         query.addAscendingOrder("createdAt")
         query.findObjectsInBackground { (chats: [PFObject]?, error: Error?) in
            if error == nil {
               if chats != nil {
                  if chats?.count != self.chats.count {
                     self.chats = chats!;
                     self.tableView.reloadData()
                     self.tableView.scrollRowToVisible(self.chats.count - 1)
                  }
               }
            }
         }
      }
   }
   
   func numberOfRows(in tableView: NSTableView) -> Int {
      return chats.count
   }
   
   func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
      return 100;
   }
   
   func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
      if let cell = tableView.make(withIdentifier: "chatCell", owner: nil) as? ChatCell {
         let chat = chats[row]
         if let message = chat["message"] as? String {
            cell.descriptionLabel.stringValue = message
         }
         if let date = chat.createdAt {
            let formater = DateFormatter()
            formater.dateFormat = "yyyy - MMM d, h:mm a"
            cell.dateLabel.stringValue = formater.string(from: date)
         }
         if let user = chat["user"] as? PFUser {
            if let name = user["name"] as? String {
               cell.nameLabel.stringValue = name
            }
            if let imageFile = user["profilePic"] as? PFFile {
               imageFile.getDataInBackground(block: { (data: Data?, error: Error?) in
                  if error == nil {
                     if data != nil {
                        let image = NSImage(data: data!)
                        cell.profilePicImageView.image = image
                     }
                  }
               })
            }
         }
         return cell
      }
      return nil
   }
   
   func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
      if commandSelector == #selector(insertNewline(_:)) {
         sendClicked(self)
      }
      return false
   }
}
