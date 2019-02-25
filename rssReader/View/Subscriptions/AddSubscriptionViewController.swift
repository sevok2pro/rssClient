//
//  AddSubscriptionViewController.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 25/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import UIKit

class AddSubscriptionViewController: UIViewController {
    @IBOutlet weak var subscriptionName: UITextField!
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        subscriptionsStorage.addSubscription(
            subscription: self.subscriptionName.text ?? ""
        );
        self.dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
