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
    
    let images = ["https://live.staticflickr.com/65535/51028317583_2d1a3d34f2_m.jpg",
                  "https://live.staticflickr.com/65535/51029043151_be1c8292e6_m.jpg",
                  "https://live.staticflickr.com/65535/51029044906_bd9965c9c5_m.jpg",
                  "https://live.staticflickr.com/65535/51029044931_f4be3a47b4_m.jpg",
                  "https://live.staticflickr.com/65535/51029045366_1c9d792073_m.jpg",
                  "https://live.staticflickr.com/65535/51029046161_f6fa1ba8ae_m.jpg",
                  "https://live.staticflickr.com/65535/51029142832_c9672b2eec_m.jpg"]
    
    let photoManager = PhotoManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var timeInterval: Double = 1.0
        var index = 0
        
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
