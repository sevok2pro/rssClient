//
//  SubscriptionsStorage.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 25/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation
import RxSwift

class SubscriptionsStorage {
    var subscriptionsDataProvider: SubscriptionsDataProvider;
    var currentSubscriptions: Array<Subscription> = [];
    var subscriptionsSubject: BehaviorSubject<Array<Subscription>> =
        BehaviorSubject(value: []);
    
    init(subscriptionsDataProvider: SubscriptionsDataProvider) {
        self.subscriptionsDataProvider = subscriptionsDataProvider;
        
        _ = self.subscriptionsSubject.subscribe(onNext: {next in
            self.currentSubscriptions = next;
        })
        
        let initialSubscriptions = self.subscriptionsDataProvider.getAvailableSubscriptions();
        self.subscriptionsSubject.onNext(initialSubscriptions);
    }
    
    func observeAvailableSubscriptions() -> Observable<Array<Subscription>> {
        return self.subscriptionsSubject.asObservable()
    }
    
    func checkSubscription(subscription : String) -> Bool {
        return self.currentSubscriptions.contains(where: {next in next.name == subscription})
    }
    
    func addSubscription(subscription : String) -> Void {
        self.checkSubscription(subscription: subscription)
            ? print("fatal error duplicate subscription")
            : self.subscriptionsSubject
                .onNext(
                    [Subscription(name: subscription)] + self.currentSubscriptions
                )
    }
}

let subscriptionsStorage: SubscriptionsStorage = SubscriptionsStorage(
    subscriptionsDataProvider: subscriptionsDataProvider
)
