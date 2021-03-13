//
//  NetworkManager.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/13.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    private init() {
        
    }
    
    func getFeedList(completion: @escaping ((Feed?)->Void)) {
        let api = API.sharedInstance.PHOTOS
        AF.request(api, parameters: ["format":"json", "nojsoncallback":"1"])
            .validate(contentType: ["application/json"])
            .responseJSON { response in
            switch response.result {
                case .success(_):
                    if let data = response.data {
                        let decoder = JSONDecoder()
                        if let feed = try? decoder.decode(Feed.self, from: data) {
                            completion(feed)
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}


class API {
    static let sharedInstance = API()
    
    private init() {}
    
    let HOST = "https://www.flickr.com/services/feeds/photos_public.gne"
    var PHOTOS: String {
        return "\(HOST)"
    }
}

