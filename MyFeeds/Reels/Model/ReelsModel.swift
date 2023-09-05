//
//  ReelsModel.swift
//  MyFeeds
//
//  Created by Ayush Garg on 03/09/23.
//

import Foundation

enum Reels {
    enum Refresh {
        struct Request {
        }
        struct Response {
            var urls: [URL]
        }
    }
}

struct ReelsData: Decodable {
    let data: [String]
}
