//
//  ChannelsViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 13/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa
import Parse

class ChannelsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

   @IBOutlet weak var profilePicImageView: NSImageView!
   @IBOutlet weak var nameLabel: NSTextField!
   @IBOutlet weak var tableView: NSTableView!
   
   var chatVC : ChatViewController?
   var addChannelWC : NSWindowController?
   var channels : [PFObject] = []
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.dataSource = self;
      tableView.delegate = self;
    }
   
   override func viewDidAppear() {
       loadUserData()
      getChannels()
   }
   
   override func viewWillDisappear() {
      addChannelWC?.close()
   }
   
   func loadUserData() {
      if let user = PFUser.current() {
         if let name = user["name"] as? String {
            nameLabel.stringValue = name
         }
         if let img = user["profilePic"] as? PFFile {
            img.getDataInBackground(block: { (data: Data?, error: Error?) in
               if (error == nil) {
                  if (data != nil) {
                     let image = NSImage(data: data!);
                     self.profilePicImageView.image = image                     
                  }
               }
            })
         }
      }
   }
    
   @IBAction func logoutClicked(_ sender: Any) {
      PFUser.logOut()
      if let mainWC = self.view.window?.windowController as? MainWindowController {
         mainWC.moveToLogin()
      }
   }
   
   @IBAction func addClicked(_ sender: Any) {
         addChannelWC = storyboard?.instantiateController(withIdentifier: "addChannelWC") as? NSWindowController
         addChannelWC?.showWindow(nil)
   }
   
   func getChannels() {
      let query = PFQuery(className: "Channel")
      query.order(byAscending: "title")
      query.findObjectsInBackground { (channels: [PFObject]?, error: Error?) in
         if channels != nil {
            self.channels = channels!
            self.tableView.reloadData()
         }
      }
   }
   
   
   func numberOfRows(in tableView: NSTableView) -> Int {
      return channels.count
   }
   
   func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
      let channel = channels[row]
      
      if let cell = tableView.make(withIdentifier: "channelCell", owner: nil) as? NSTableCellView {
         if let title = channel["title"] as? String {
            cell.textField?.stringValue = "#\(title)"
            return cell
         }
         
      }
      return nil
   }
   
   func tableViewSelectionDidChange(_ notification: Notification) {
      if tableView.selectedRow >= 0 {
         let channel = channels[tableView.selectedRow]
         chatVC?.updateChannel(channel: channel)
      }
   }
}

