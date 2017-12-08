//
//  ListsViewController.swift
//  Journal
//
//  Created by 黃珮鈞 on 2017/12/8.
//  Copyright © 2017年 黃珮鈞. All rights reserved.
//

import UIKit
import Firebase

class ListsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var journals: [Journal] = []
    var journalIDs: [String] = []
    
    @IBOutlet weak var listsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            self.listsTableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JournalTableViewCell
        
        let journal = journals[indexPath.row]
        
        cell.titleLabel.text = journal.title
//        cell.authorButton.setTitle(article.author, for: .normal)
//        cell.authorButton.addTarget(self, action: #selector(userArticles), for: .touchUpInside)
//        cell.likeButton.addTarget(self, action: #selector(likeArticle), for: .touchUpInside)
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
