//
//  NoteCellTableViewCell.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 11/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import UIKit

class NoteCellTableViewCell: UITableViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
