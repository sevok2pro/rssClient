//
//  userData.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 13/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation

class SubscriptionsStorage {
    var subscriptions: Set<String> = [];
    
    func getSubscriptions() -> Array<String> {
        return Array(self.subscriptions);
    }
    
    func checkSubscription(uid: String) -> Bool {
        return self.subscriptions.contains(uid);
    }
    
    func addSubscription(uid: String) -> Void {
        self.subscriptions.insert(uid)
        print(subscriptions)
    }
    
    func removeSubscription(uid: String) -> Void {
        self.subscriptions.remove(uid)
        print(subscriptions)
    }
}

class UserData {
    let subscriptionsStorage = SubscriptionsStorage()
}

let userData = UserData();
