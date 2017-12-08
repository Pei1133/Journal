//
//  ListsTableViewController.swift
//  Journal
//
//  Created by 黃珮鈞 on 2017/12/8.
//  Copyright © 2017年 黃珮鈞. All rights reserved.
//

import UIKit
import Nuke
import Firebase

class ListsTableViewController: UITableViewController {

    var journals: [Journal] = []
    var journalIDs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Database.database().reference().child("journals").observe(.value) { (snapshot) in
            self.journals.removeAll()
            for child in snapshot.children {
                let childrenSnapshot = child as! DataSnapshot
                let journal = Journal(snapshot: childrenSnapshot)
                self.journals.insert(journal, at: 0)
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! JournalTableViewCell
        let journal = journals[indexPath.row]
        let photoImgURL = journal.photoURL
        
        cell.titleLabel.text = journal.title
        Nuke.loadImage(
            with: URL(string: photoImgURL)!,
            into: cell.listImageView
        )
        return cell
    }


    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == UITableViewCellEditingStyle.delete {
    ////            self.allNames[indexPath.section]?.remove(at: indexPath.row)
    //            tableView.setEditing(false, animated: true)
    //        }
    //
    //        else if editingStyle == UITableViewCellEditingStyle.insert
    //        {
    ////            allNames[indexPath.section]?.insert("插入的", at: indexPath.row)
    //            tableView.setEditing(false, animated: true)
    //        }
    //
    //        tableView.reloadData()
    //    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.setEditing(false, animated: true)

            let ref = Database.database().reference()
            let key = ref.child("journals").key
            let post = ["content": nil,
                        "date": nil,
                        "title": nil,
                        "photoURL": nil] as [String : Any?]
            let childUpdates = ["/journals/\(key)": post]
            ref.updateChildValues(childUpdates)
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


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
