//
//  Photo.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/13.
//

import Foundation
import SwiftyJSON

class Feed: Codable {
    var title: String
    var link: String
    var description: String
    var modified: String
    var generator: String
    var items: [Photo]
    
    init(title: String, link: String, description: String, modified: String, generator: String, items: [Photo]) {
        self.title = title
        self.link = link
        self.description = description
        self.modified = modified
        self.generator = generator
        self.items = items
    }
}

class Photo: Codable {
    var title: String
    var link: String
    var media: Media
    var date_taken: String
    var description: String
    var published: String
    var author: String
    var author_id: String
    var tags: String
    
    init(title: String, link: String, media: Media, date_taken: String, description: String, published: String, author: String, author_id: String, tags: String) {
        self.title = title
        self.link = link
        self.media = media
        self.date_taken = date_taken
        self.description = description
        self.published = published
        self.author = author
        self.author_id = author_id
        self.tags = tags
    }
}

struct Media: Codable {
    var m: String
}
