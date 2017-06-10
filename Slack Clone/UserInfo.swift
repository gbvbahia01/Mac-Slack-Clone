//
//  UserInfo.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 09/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Foundation

class UserInfo {
   var name : String?
   var email : String?
   var pass : String?
   var dataImg : Data?
   
   init(email: String, pass: String, name: String?, dataImg: Data?) {
      self.name = name;
      self.pass = pass;
      self.email = email;
      self.dataImg = dataImg
   }

}
