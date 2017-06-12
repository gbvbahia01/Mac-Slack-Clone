//
//  UserDao.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 09/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Foundation
import Parse

class UserDao {
   
   static let NEW_USER_CREATED : String = "NEW_USER_CREATED";
   
   var notifier : NotifierProtocol;
   
   init (not: NotifierProtocol) {
      self.notifier = not;
   }
   
   func saveNewUser(userInfo: UserInfo) {
      let user = PFUser()
      user.email = userInfo.email;
      user.password = userInfo.pass;
      user.username = userInfo.email;
      user["name"] = userInfo.name;
      if let data = userInfo.dataImg {
         user["profilePic"] = PFFile(data: data)
      }
      user.signUpInBackground { (success: Bool, error: Error?) in
            self.notifier.notify(type: UserDao.NEW_USER_CREATED, error: error)
      }
   }
}
