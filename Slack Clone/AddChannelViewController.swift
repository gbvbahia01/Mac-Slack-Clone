//
//  AddChannelViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 14/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa
import Parse

class AddChannelViewController: NSViewController {

   @IBOutlet weak var titleTextField: NSTextField!
   
   @IBOutlet weak var descriptionTextField: NSTextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
   @IBAction func addChannelClicked(_ sender: Any) {
      let channel = PFObject(className: "Channel")
      channel["title"] = titleTextField.stringValue
      channel["descrip"] = descriptionTextField.stringValue
      channel.saveInBackground { (success:Bool, error:Error?) in
         if success {
            self.view.window?.close()
         }else {
            print("Error crating channel")
         }
      }
      
   }
}
