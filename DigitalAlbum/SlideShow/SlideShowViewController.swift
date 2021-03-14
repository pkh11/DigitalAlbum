//
//  SlideShowViewController.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/13.
//

import UIKit
import Kingfisher

class SlideShowViewController: UIViewController {
    
    @IBOutlet weak var slideShowView: UIImageView!
    
    var timer: Timer = Timer()
    let photoManager = PhotoManager.sharedInstance
    let settingsManager = SettingsManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var index = 0
        var timeInterval: Double = 1.0
        if !settingsManager.timeInterval.isEmpty {
            if let strToDouble = Double(settingsManager.timeInterval) {
                timeInterval = strToDouble
            }
        }
    
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            // timerInterval : transitionStyle interval = 1: 0.6
            if let feed = self.photoManager.feed {
                let items = feed.items
                let url = URL(string: items[index].media.m)
                self.slideShowView.kf.setImage(with: url, options: [.transition(.fade(timeInterval * 0.6)), .forceTransition])
                
                if index < items.count - 1 {
                    index += 1
                }
            }
        }
        timer.fire()
        
    }
    
    @IBAction func closeSlideShowView(_ sender: Any) {
        timer.invalidate()
        self.dismiss(animated: true, completion: nil)
    }
}
