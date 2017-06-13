//
//  MainWindowController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 09/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

   var loginVC : LoginViewController?
   var createAccountVC : CreateAccountViewController?
   var splitViewController : SplitViewController?
   
    override func windowDidLoad() {
        super.windowDidLoad()
      loginVC = contentViewController as? LoginViewController
    }

   func moveToCreateAccount() {
      if createAccountVC == nil {
         createAccountVC = storyboard?.instantiateController(withIdentifier: "createAccountID") as? CreateAccountViewController
      }
       window?.contentView = createAccountVC?.view;
   }
   
   func moveToLogin() {
      window?.contentView = loginVC?.view
   }
   
   func moveToChat() {
      if splitViewController == nil {
         splitViewController = storyboard?.instantiateController(withIdentifier: "splitVC") as? SplitViewController
      }
      window?.contentView = splitViewController?.view;
   }
}
