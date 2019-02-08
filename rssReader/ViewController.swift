//
//  ViewController.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 08/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("view did load!")
    }
    
    @IBAction func onTapButton(_ sender: UIButton) {
        label.text = "LOL!"
    }
}

