//
//  PhotoManager.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/13.
//

import Foundation

class PhotoManager {
    static let sharedInstance = PhotoManager()
    let networkManager = NetworkManager.sharedInstance
    var feed: Feed?
    
    private init() {
        
    }
    
    func fetchFeed(_ completion: @escaping ((Feed?)->Void)) {
        networkManager.getFeedList { data in
            guard let data = data else { return }
            self.feed = data
            completion(self.feed)
        }
    }
}
