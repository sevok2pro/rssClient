//
//  SubscriptionsDataProvider.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 13/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation

protocol SubscriptionProtocol {
    var name: String { get }
    var describe: String { get }
}

class Subscription: SubscriptionProtocol {
    var name: String;
    var describe: String;
    init(name: String) {
        self.name = name;
        self.describe = "abbab";
    }
}

func makeSubscription(name: String) -> SubscriptionProtocol {
    return Subscription(name: name)
}

class SubscriptionsDataProvider {
    func getAvailableSubscriptions() -> Array<SubscriptionProtocol> {
        return ["one", "two", "three"].map { next in makeSubscription(name: next)}
    }
}

let subscriptionsDataProvider = SubscriptionsDataProvider();
