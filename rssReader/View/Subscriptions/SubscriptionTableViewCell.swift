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
    var uid: String = "";
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        if(self.uid != "") {
            self.switch.isOn
                ? userData.userSubscriptionsStorage.addSubscription(uid: self.uid)
                : userData.userSubscriptionsStorage.removeSubscription(uid: self.uid)
        }
    }
    
}
