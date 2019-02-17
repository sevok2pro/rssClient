//
//  dependencyResolver.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 12/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation
import RxSwift

class Note {
    var text: String
    
    init(text: String) {
        self.text = text;
    }
}

class NewsStorage {
    var notes: Array<Note> = []
    var notesSubject: BehaviorSubject<Array<Note>> = BehaviorSubject(value : []);
    
    init() {
        let connect = userData.subscriptionsStorage.observeSubscriptions()
            .map({subscriptionsSet in Array(subscriptionsSet).map({next in Note(text: next)})})
            .multicast(notesSubject)
        
        _ = connect.connect();
    }
    
    func observeNotes() -> Observable<Array<Note>> {
        return self.notesSubject.asObserver();
    }
}

let newsStorage = NewsStorage();
