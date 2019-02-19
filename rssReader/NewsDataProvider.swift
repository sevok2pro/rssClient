//
//  NewsDataProvider.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 17/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation
import RxSwift

class RssNews {
    var title: String;
    var description: String;
    var link: String;
    var imageLink: String;
    
    init(titleSalt: Int, feed: String) {
        self.title = "News from feed: \(feed), order: \(String(titleSalt))";
        self.description = "Any description for feed:\(feed)";
        self.link = "my.com";
        self.imageLink = "my.com";
    }
}

class NewsDataProvider {
    var newsCache: Dictionary<String, Observable<RssNews>> = Dictionary()
    func observeNews(feed: String) -> Observable<RssNews> {
        if (!newsCache.keys.contains(where: { (key: String) -> Bool in
            key == feed
        })) {
            let newsObserver = Observable
                .interval(1.0, scheduler: MainScheduler.instance)
                .startWith(-2, -1, 0)
                .map({ next in RssNews(titleSalt: next, feed: feed) })
                .replay(20)
            _ = newsObserver.connect();
            newsCache[feed] = newsObserver;
        }
        return newsCache[feed] ?? Observable.error("Cache miss in NewsDataProvider" as! Error)
    }
}

let newsDataProvider = NewsDataProvider();
