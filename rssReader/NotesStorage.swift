//
//  dependencyResolver.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 12/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation

class Note {
    var text: String
    
    init(text: String) {
        self.text = text;
    }
}

class NotesStorage {
    var notes: [Note] = [Note(text: "lol")]
    func getNotes() -> Array<Note> {
        return self.notes
    }
}

let notesStorage = NotesStorage();
