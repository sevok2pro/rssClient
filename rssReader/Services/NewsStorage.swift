//
//  dependencyResolver.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 12/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation
import RxSwift

class NewsStorage {
    var notes: Array<RssNews> = []
    var newsSubject: PublishSubject<Array<RssNews>> = PublishSubject();
    
    init(userData: UserData, newsDataProvider: NewsDataProvider) {
        let connect = userData.userSubscriptionsStorage.observeSubscriptions()
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
                            accumulator: { (acc: Array<RssNews>, next: RssNews) -> Array<RssNews> in [next] + acc
                        })
                }
            })
            .multicast(newsSubject)
        
        _ = connect.connect();
    }
    
    func observeNotes() -> Observable<Array<RssNews>> {
        return self.newsSubject.asObserver();
    }
}

let newsStorage = NewsStorage(userData: userData, newsDataProvider: newsDataProvider);
