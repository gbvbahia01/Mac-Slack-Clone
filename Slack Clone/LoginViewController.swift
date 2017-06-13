//
//  LoginViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 08/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa
import Parse

class LoginViewController: NSViewController {
   
   @IBOutlet weak var emailTextField: NSTextField!
   
   @IBOutlet weak var passwordTextField: NSSecureTextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      emailTextField.stringValue = "g@g.com"
      // Do any additional setup after loading the view.
   }
   
   @IBAction func loginClicked(_ sender: Any) {
      PFUser.logInWithUsername(inBackground: emailTextField.stringValue,
                               password: passwordTextField.stringValue) { (
                                 user: PFUser?, error: Error?) in
                                 if (error == nil) {
                                    if let mainWC = self.view.window?.windowController as? MainWindowController {
                                       mainWC.moveToChat()
                                    }
                                 }
                                 else {
                                    print("problem")
                                 }
      }
   }
   
   @IBAction func createAccountClicked(_ sender: Any) {
      if let mainWC = view.window?.windowController as? MainWindowController {
         mainWC.moveToCreateAccount()
      }
   }
   
   
}

