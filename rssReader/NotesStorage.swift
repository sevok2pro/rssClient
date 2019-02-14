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

class NotesStorage {
    var notes: Array<Note> = []
    var notesSubject: BehaviorSubject<Array<Note>> = BehaviorSubject(value : []);
    
    init() {
        _ = Observable<Int>.interval(2.0, scheduler: MainScheduler.instance)
            .subscribe(
                onNext: {next in self.notesSubject.onNext([Note(text: String(next))])}
            )
    }
    
    func getNotes() -> Array<Note> {
        return notes
    }
    
    func observeNotes() -> Observable<Array<Note>> {
        return self.notesSubject.asObserver();
    }
}

let notesStorage = NotesStorage();
