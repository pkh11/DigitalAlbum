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
    
    private init() {}
    
    func getFeedList(completion: @escaping (Result<Data, Error>) -> Void) {
        let api = API.sharedInstance.PHOTOS
        AF.request(api, parameters: ["format":"json", "nojsoncallback":"1", "lang":"ko-kr"])
            .validate(contentType: ["application/json"])
            .responseJSON { response in
            switch response.result {
                case .success(_):
                    if let data = response.data {
                        completion(.success(data))
                    }
                case .failure(let error):
                    completion(.failure(error))
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

