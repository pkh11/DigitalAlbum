//
//  PhotoCollectionViewCell.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/13.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(_ item: Photo) {
        let url = URL(string: item.media.m)
        imageView.kf.setImage(with: url)
    }
}

class PhotoCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var totalCount: UILabel!
}
