//
//  userData.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 13/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation
import RxSwift

class SubscriptionsStorage {
    var subscriptions: Set<String> = [];
    var subscriptionSubject: BehaviorSubject<Set<String>> = BehaviorSubject(value: [])
    
    func getSubscriptions() -> Array<String> {
        return Array(self.subscriptions);
    }
    
    func checkSubscription(uid: String) -> Bool {
        return self.subscriptions.contains(uid);
    }
    
    func addSubscription(uid: String) -> Void {
        self.subscriptions.insert(uid)
        self.subscriptionSubject.onNext(self.subscriptions)
    }
    
    func removeSubscription(uid: String) -> Void {
        self.subscriptions.remove(uid)
        self.subscriptionSubject.onNext(self.subscriptions)
    }
    
    func observeSubscriptions() -> Observable<Set<String>> {
        return self.subscriptionSubject.asObservable();
    }
}

class UserData {
    var subscriptionsStorage: SubscriptionsStorage;
    
    init(subscriptionsStorage: SubscriptionsStorage) {
        self.subscriptionsStorage = subscriptionsStorage
    }
}

let userData = UserData(
    subscriptionsStorage: SubscriptionsStorage()
);
