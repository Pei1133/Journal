//
//  AddJournalViewController.swift
//  Journal
//
//  Created by 黃珮鈞 on 2017/12/8.
//  Copyright © 2017年 黃珮鈞. All rights reserved.
//

import UIKit
import Firebase

class AddJournalViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var journalTextField: UITextView!
    @IBOutlet weak var addImageView: UIImageView!
   
    @IBAction func goSave(_ sender: Any) {

        let ref = Database.database().reference()
        let journalRef = ref.child("journals").childByAutoId()
//        let childAutoID = journalRef.key


        guard let title = self.titleTextField.text, let content = self.journalTextField.text else{
            print("Form is not valid")
            return
        }
        
        let value = [
            "title": title,
            "content": content,
            "date": "\(Date())",
            ] as [String : Any]
        
        journalRef.setValue(value)
        
//          FirebaseRef.databaseProducts.child("\(product.id.rawValue)").updateChildValues(value)
        
//        // store journal ids in user
//        let userArticlesReference = ref.child("users").child(uid).child("articles").childByAutoId()
//        userArticlesReference.setValue(childAutoID)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
