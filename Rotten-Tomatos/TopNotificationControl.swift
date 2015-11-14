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
    
    let timeOut = 0.3
    let delay = 0.0
    let maxAlpha = 0.7
    func showUp(){
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = CGFloat(self.maxAlpha)
            }, completion: {(data) -> Void in
                let i = 0
        })
    }
    
    func hide(){
        UIView.animateWithDuration(timeOut, delay: delay, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: {(data) -> Void in
                let i = 0
        })
    }
}
