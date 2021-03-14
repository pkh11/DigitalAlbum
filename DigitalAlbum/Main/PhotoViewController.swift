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

    @IBAction func pressOptionButton(_ sender: Any) {
        let selectAlert = UIAlertController(title: "목록보기", message: nil, preferredStyle: .actionSheet)
        
        let treeType = UIAlertAction(title: "3개", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
//            self.reLayout(3)
        })
        let twoType = UIAlertAction(title: "2개", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
//            self.reLayout(2)
        })
        
        let oneType = UIAlertAction(title: "1개", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
//            self.reLayout(1)
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        selectAlert.addAction(treeType)
        selectAlert.addAction(twoType)
        selectAlert.addAction(oneType)
        selectAlert.addAction(cancelAction)
        
        self.present(selectAlert, animated: true, completion: nil)
    }
    
    @IBAction func moveToSettings(_ sender: Any) {
        let settingsStoryboard = UIStoryboard.init(name: "Settings", bundle: nil)
        guard let settingsVC = settingsStoryboard.instantiateViewController(identifier: "settingsViewController") as? SettingsViewController else { return }
        self.navigationController?.pushViewController(settingsVC, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

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


