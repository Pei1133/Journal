//
//  Journal.swift
//  Journal
//
//  Created by 黃珮鈞 on 2017/12/8.
//  Copyright © 2017年 黃珮鈞. All rights reserved.
//

import UIKit
import Firebase

class Journal {
    var title: String = ""
    var text: String = ""
    var date: String = ""
//    var imageURL: String = ""
    let ref: DatabaseReference!

    init(snapshot: DataSnapshot) {
        self.ref = snapshot.ref
        if let value = snapshot.value as? [String: Any] {
            self.title = value["title"] as! String
            self.text = value["content"] as! String
            self.date = value["publish date"] as! String
        }
    }
}
