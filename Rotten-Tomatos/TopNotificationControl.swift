//
//  TopNotificationControl.swift
//  Rotten-Tomatos
//
//  Created by Anh-Tu Hoang on 11/14/15.
//  Copyright © 2015 hatu. All rights reserved.
//

import UIKit

class TopNotificationControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var lblMessage: UILabel!
    
    var message: String!{
        didSet{
            self.lblMessage.text = self.message
        }
    }
}
