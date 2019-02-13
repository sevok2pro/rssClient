//
//  rssNews.swift
//  rssReader
//
//  Created by Vsevolod Liberov on 13/02/2019.
//  Copyright © 2019 Seva. All rights reserved.
//

import Foundation

protocol rssNews {
    var title: String { get }
    var description: String { get }
    var link: String { get }
    var imageLink: String { get }
}
