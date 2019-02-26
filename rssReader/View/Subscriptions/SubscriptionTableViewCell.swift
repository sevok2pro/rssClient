//
//  SubscriptionTableViewCell.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 13/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import UIKit

class SubscriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var name: UILabel!
    // TODO: replace boolean argument with named argument
    var onSwitchHandler: ((_ switchState: Bool) -> Void)?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        self.onSwitchHandler!(self.switch.isOn);
    }
    
}
