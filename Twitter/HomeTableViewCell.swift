//
//  HomeTableViewCell.swift
//  Twitter
//
//  Created by Joy Paul on 3/4/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tweet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
