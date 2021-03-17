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
    var cellCount: Int = 3
    var minSpacing: CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.refreshControl = UIRefreshControl()
        photoCollectionView.refreshControl?.attributedTitle = NSAttributedString(string: "새로고침")
        photoCollectionView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        fetchFeedandPhotos()
    }
    
    @objc func refresh() {
        fetchFeedandPhotos()
        photoCollectionView.refreshControl?.endRefreshing()
    }
    
    func fetchFeedandPhotos() {
        photoManager.fetchFeed { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                }
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
    
    @IBAction func moveToSettings(_ sender: Any) {
        let settingsStoryboard = UIStoryboard.init(name: "Settings", bundle: nil)
        guard let settingsVC = settingsStoryboard.instantiateViewController(identifier: "settingsViewController") as? SettingsViewController else { return }
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewCellWithd = collectionView.frame.width / CGFloat(cellCount) - minSpacing
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "photoCollectionViewHeader", for: indexPath) as? PhotoCollectionHeaderView else { return UICollectionReusableView() }
            
            if let countOfItems = photoManager.feed {
                headerView.totalCount.text = "총 \(countOfItems.items.count)건"
            }
            return headerView
        default:
            fatalError("Unexpected element kind")
        }
    }
}


