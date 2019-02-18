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
    var notesSubject: PublishSubject<Array<News>> = PublishSubject();
    
    init(userData: UserData, newsDataProvider: NewsDataProvider) {
        let connect = userData.subscriptionsStorage.observeSubscriptions()
            .flatMapLatest({(feeds: Set<String>) -> Observable<Array<RssNews>> in
                if(feeds.count == 0) {
                    return Observable.just([])
                } else {
                    return Observable
                        .from(feeds.map({(feed: String) -> Observable<RssNews> in
                            newsDataProvider.observeNews(feed: feed)})
                        )
                        .merge()
                        .scan(
                            [],
                            accumulator: { (acc: Array<RssNews>, next: RssNews) -> Array<RssNews> in acc + [next]
                        })
                }
            })
            .map({(next: Array<RssNews>) -> Array<News> in
                next.map({(rssNews: RssNews) -> News in
                    News(text: rssNews.title)
                }).reversed()
            })
            .multicast(notesSubject)
        
        _ = connect.connect();
    }
    
    func observeNotes() -> Observable<Array<News>> {
        return self.notesSubject.asObserver();
    }
}

let newsStorage = NewsStorage(userData: userData, newsDataProvider: newsDataProvider);
