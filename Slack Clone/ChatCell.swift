//
//  ChatCell.swift
//  Slack Clone
//
//  Created by Guilherme B V Bahia on 14/06/17.
//  Copyright © 2017 Planet Bang. All rights reserved.
//

import Cocoa

class ChatCell: NSTableCellView {
   
   @IBOutlet weak var profilePicImageView: NSImageView!
   @IBOutlet weak var nameLabel: NSTextField!
   @IBOutlet weak var dateLabel: NSTextField!
   @IBOutlet weak var descriptionLabel: NSTextField!
   
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
