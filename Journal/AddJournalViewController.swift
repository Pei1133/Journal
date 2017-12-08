//
//  AddJournalViewController.swift
//  Journal
//
//  Created by 黃珮鈞 on 2017/12/8.
//  Copyright © 2017年 黃珮鈞. All rights reserved.
//

import UIKit
import Firebase

class AddJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var journalTextField: UITextView!
    @IBOutlet weak var pickUpImageButtom: UIButton!

    @IBAction func tapButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func goSave(_ sender: Any) {

        let ref = Database.database().reference()
        let journalRef = ref.child("journals").childByAutoId()

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

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "確認刪除"
//    }
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

    //    MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = chosenImage
            imageView.contentMode = .scaleAspectFit
        }
        dismiss(animated:true, completion: nil)
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
