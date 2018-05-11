//
//  EditTableViewController.swift
//  FilterShowcase
//
//  Created by JungMoon-Mac on 2018. 3. 29..
//  Copyright © 2018년 Sunset Lake Software. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EditTableViewController: UITableViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            print("indexPath \(indexPath)")
            if indexPath.row == 0{
                UserDefaults.standard.removeObject(forKey: "selected_filter_id")
                UserDefaults.standard.removeObject(forKey: "selected_filter_no")
            }
            else if let selectedCell = self.tableView.cellForRow(at: indexPath) as? EditCell{
                if selectedCell.filterIdTextField.text?.isEmpty ?? true{
                    self.tableView.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.none)
                    Toast.showToast(title: "No filter id.")
                }
                else{
                    UserDefaults.standard.setValue(selectedCell.filterIdTextField.text!, forKey: "selected_filter_id")
                    UserDefaults.standard.setValue(String(indexPath.row), forKey: "selected_filter_no")
                    UserDefaults.standard.synchronize()
                    GoogleDownloader.downlaod(driveFileId: selectedCell.filterIdTextField.text!)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            if let filterNo = UserDefaults.standard.string(forKey: "selected_filter_no"), let no = Int(filterNo){
                self.tableView.selectRow(at: IndexPath(item: no, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.none)
            }
            else{
                self.tableView.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.none)
            }
        }
    }
}


class EditCell: UITableViewCell, UITextFieldDelegate{
    @IBOutlet weak var filterIdTextField: UITextField!
    var filterNo:Int = 0{
        didSet{
            if let filterId = UserDefaults.standard.string(forKey: "filter_file_no_\(filterNo)"){
                filterIdTextField.text = filterId
            }
        }
    }
    
    override func awakeFromNib() {
        filterNo = filterIdTextField.tag
        filterIdTextField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UserDefaults.standard.set(textField.text, forKey: "filter_file_no_\(filterNo)")
        UserDefaults.standard.synchronize()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
