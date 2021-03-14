//
//  SettingsManager.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/13.
//

import Foundation


class SettingsManager {
    static var sharedInstance = SettingsManager()
    var timeInterval: String = ""
    
    private init() {
        self.timeInterval = fetchTimeInterval()
    }
    
    func fetchTimeInterval() -> String {
        if let time = UserDefaults.standard.object(forKey: "timeInterval") as? String {
            return time
        }
        return ""
    }
    
    func setTimeInterval(_ time: String) {
        if let _ = UserDefaults.standard.object(forKey: "timeInterval") as? String {
            UserDefaults.standard.removeObject(forKey: "timeInterval")
        }
        UserDefaults.standard.setValue(time, forKey: "timeInterval")
        
        timeInterval = fetchTimeInterval()
    }
}

