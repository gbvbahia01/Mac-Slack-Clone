//
//  ChannelsViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 13/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa
import Parse

class ChannelsViewController: NSViewController {

   @IBOutlet weak var profilePicImageView: NSImageView!
   
   @IBOutlet weak var nameLabel: NSTextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
   override func viewDidAppear() {
       loadUserData()
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
}
