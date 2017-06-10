//
//  NotifierProtocol.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 09/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Foundation

protocol NotifierProtocol {
   
   func notify(type: String, error: Error?)
}
