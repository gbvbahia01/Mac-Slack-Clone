//
//  LoginViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 08/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
   }


   @IBAction func createAccountClicked(_ sender: Any) {
      if let mainWC = view.window?.windowController as? MainWindowController {
         mainWC.moveToCreateAccount()
      }
   }


}

