//
//  SubscriptionsDataProvider.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 13/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation

class Subscription {
    var name: String;
    var describe: String;
    init(name: String) {
        self.name = name;
        self.describe = "abbab";
    }
}

class SubscriptionsDataProvider {
    func getAvailableSubscriptions() -> Array<Subscription> {
        return ["one", "two", "three"].map { next in Subscription(name: next) }
    }
}

let subscriptionsDataProvider = SubscriptionsDataProvider();
