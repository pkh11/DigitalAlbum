//
//  Photo.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/13.
//

import Foundation
import SwiftyJSON

struct Feed: Codable {
    var title: String
    var link: String
    var description: String
    var modified: String
    var generator: String
    var items: [Photo]
}

struct Photo: Codable {
    var title: String
    var link: String
    var media: Media
    var date_taken: String
    var description: String
    var published: String
    var author: String
    var author_id: String
    var tags: String
}

struct Media: Codable {
    var m: String
}
