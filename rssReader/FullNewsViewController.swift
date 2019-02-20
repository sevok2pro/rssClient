//
//  FullNewsViewController.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 20/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import UIKit

class FullNewsViewController: UIViewController {
    @IBOutlet weak var fullNewsLink: UILabel!
    var newsLink: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullNewsLink.text = self.newsLink;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
