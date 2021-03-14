//
//  SettingsTableViewCell.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/13.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        type.text = "시간설정"
    }
    
    func updateUI(time: String) {
        if !time.isEmpty {
            value.text = "\(time)초"
        } else {
            value.text = ""
        }
    }
}
