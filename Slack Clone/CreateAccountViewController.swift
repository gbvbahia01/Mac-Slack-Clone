//
//  CreateAccountViewController.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 09/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa
import Parse

class CreateAccountViewController: NSViewController, NotifierProtocol {
   
   @IBOutlet weak var nameTextField: NSTextField!
   @IBOutlet weak var emailTextField: NSTextField!
   @IBOutlet weak var passwordTextField: NSSecureTextField!
   @IBOutlet weak var profilePicImageView: NSImageView!
   var userDao : UserDao?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      userDao = UserDao(not: self)
   }
   
   @IBAction func loginClicked(_ sender: Any) {
      if let mainWC = view.window?.windowController as? MainWindowController {
         mainWC.moveToLogin()
      }
   }
   
   @IBAction func chooseImageClicked(_ sender: Any) {
   }
   
   @IBAction func createAccountClicked(_ sender: Any) {
      let user = UserInfo(email: emailTextField.stringValue,
                          pass: passwordTextField.stringValue,
                          name: nameTextField.stringValue,
                          dataImg: nil)
      userDao?.saveNewUser(userInfo: user)
   }
   
   func notify(type: String, error: Error?) {
      if error != nil {
         print(error?.localizedDescription ?? "We have a error")
         return
      }
      
      if (UserDao.NEW_USER_CREATED == type) {
         print(UserDao.NEW_USER_CREATED)
      }
   }
}
