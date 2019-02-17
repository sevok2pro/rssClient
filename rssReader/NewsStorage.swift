//
//  dependencyResolver.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 12/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation
import RxSwift

class News {
    var text: String
    
    init(text: String) {
        self.text = text;
    }
}

class NewsStorage {
    var notes: Array<News> = []
    var notesSubject: BehaviorSubject<Array<News>> = BehaviorSubject(value : []);
    
    init() {
        let connect = userData.subscriptionsStorage.observeSubscriptions()
            .map({subscriptionsSet in Array(subscriptionsSet).map({next in News(text: next)})})
            .multicast(notesSubject)
        
        _ = connect.connect();
    }
    
    func observeNotes() -> Observable<Array<News>> {
        return self.notesSubject.asObserver();
    }
}

let newsStorage = NewsStorage();
