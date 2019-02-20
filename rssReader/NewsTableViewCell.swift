//
//  NoteCellTableViewCell.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 11/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsShortDescription: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    var onTapHandler: (() -> Void)? = nil
    
    @objc func tapEdit(_ sender: UITapGestureRecognizer) {
        if(self.onTapHandler != nil) {
            self.onTapHandler!()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gestureRecognizer: UIGestureRecognizer =
            UITapGestureRecognizer(
                target: self,
                action: #selector(self.tapEdit(_:))
            )
        self.addGestureRecognizer(gestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
