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
    @IBOutlet weak var filterIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rx.itemSelected.subscribe(onNext: { [unowned self] indexPath in
            print("indexPath \(indexPath)")
            if indexPath.row == 0{
                UserDefaults.standard.removeObject(forKey: "filter_file_id")
            }
            else if indexPath.row == 1{
                if self.filterIdTextField.text?.isEmpty ?? true{
                    self.tableView.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.none)
                    Toast.showToast(title: "No filter id.")
                }
                else{
                    UserDefaults.standard.setValue(self.filterIdTextField.text!, forKey: "filter_file_id")
                }
                
            }
            
            UserDefaults.standard.synchronize()
        }).disposed(by: disposeBag)
        
        DispatchQueue.main.async {
            if let driveId = UserDefaults.standard.string(forKey: "filter_file_id"){
                self.filterIdTextField.text = driveId
                self.tableView.selectRow(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.none)
            }
            else{
                self.tableView.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.none)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if tableView.indexPathForSelectedRow?.row ?? 0 == 1 {
            GoogleDownloader.downlaod(driveFileId: self.filterIdTextField.text!)
        }
    }

    //MARK: - Table view data source
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
