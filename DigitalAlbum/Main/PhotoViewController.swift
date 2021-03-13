//
//  ViewController.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/12.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet var photoCollectionView: UICollectionView!
    let photoManager = PhotoManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        fetchFeedandPhotos()
    }
    
    func fetchFeedandPhotos() {
        photoManager.fetchFeed { feed in
            DispatchQueue.main.async {
                self.photoCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func startSlideShow(_ sender: Any) {
        let slideShowStoryboard = UIStoryboard.init(name: "SlideShow" , bundle: nil)
        guard let slideShowVC = slideShowStoryboard.instantiateViewController(identifier: "slideShowViewController") as? SlideShowViewController else {
            return
        }
        slideShowVC.modalPresentationStyle = .fullScreen
        self.present(slideShowVC, animated: true, completion: nil)
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewCellWithd = collectionView.frame.width / 3 - 1
        return CGSize(width: collectionViewCellWithd, height: collectionViewCellWithd)
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let feed = photoManager.feed {
            return feed.items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let feed = photoManager.feed {
            cell.updateUI(feed.items[indexPath.row])
        }
        
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    
}

