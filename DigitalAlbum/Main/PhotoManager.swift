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
    
    private init() { }
    
    func fetchFeed(_ completion: @escaping ((Bool)->Void)) {
        networkManager.getFeedList { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                if let feedData = try? decoder.decode(Feed.self, from: data) {
                    self.feed = feedData
                    completion(true)
                }
            case .failure(let error):
                completion(false)
                print("\(error)")
            }
        }
    }
}
