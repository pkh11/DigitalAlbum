//
//  SettingsViewController.swift
//  DigitalAlbum
//
//  Created by 박균호 on 2021/03/13.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    let slideShowTimes = Array(1...10).map{ String($0) }
    let settingsManager = SettingsManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.tableFooterView = UIView()
        
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return slideShowTimes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return slideShowTimes[row]
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell") as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        let timeInterval = settingsManager.timeInterval
        cell.updateUI(time: timeInterval)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // view
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: self.view.frame.width, height: 200)
    
        // pickerview
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.midY, height: 200))
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let alert = UIAlertController(title: "슬라이드쇼 시간 선택", message: "", preferredStyle: .actionSheet)
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: 0, y: self.view.bounds.midY, width: 0, height: 0)
            }
        }
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { action in
            
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            self.settingsManager.setTimeInterval(self.slideShowTimes[selectedRow])
            self.settingsTableView.reloadData()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
