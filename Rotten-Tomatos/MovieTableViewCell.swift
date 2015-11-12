//
//  MovieTableViewCell.swift
//  Rotten-Tomatos
//
//  Created by Anh-Tu Hoang on 11/12/15.
//  Copyright © 2015 hatu. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var lblSynopsis: UILabel!
    var title:String! {
        didSet {
            lblTitle.text = self.title
        }
    }

    var synopsis: String! {
        didSet{
            lblSynopsis.text = self.synopsis
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
