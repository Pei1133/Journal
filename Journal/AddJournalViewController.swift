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

        guard let title = self.titleTextField.text,
            let content = self.journalTextField.text,
            let photoURL = self.imageView.image
            else{
                print("Form is not valid")
                return
            }
        
        let value = [
            "title": title,
            "content": content,
            "date": "\(Date())",
            "photoURL": photoURL
            ] as [String : Any]
        
        journalRef.setValue(value)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imageView.tintColor = UIColor.white
        imageView.backgroundColor = UIColor.black
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

//    //    MARK: - UIImagePickerControllerDelegate
//    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
//    {
//        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            imageView.image = chosenImage
//            imageView.contentMode = .scaleAspectFit
//        }
//        let uniqueString = NSUUID().uuidString
//        dismiss(animated:true, completion: nil)
//    }
    
    //    MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
    {
        var selectedImageFromPicker: UIImage?
        if let selectedImage = info[UIImagePickerControllerOriginalImage] {
            selectedImageFromPicker = selectedImage as? UIImage
//            imageView.image = selectedImage
//            imageView.contentMode = .scaleAspectFit
        }
        let uniqueString = NSUUID().uuidString
        if let selectedImage = selectedImageFromPicker {
            
            let storageRef = storage.reference().child("Photos").child("\(uniqueString).png")
            
            if let uploadData = UIImagePNGRepresentation(selectedImage) {
                // 這行就是 FirebaseStorage 關鍵的存取方法。
                storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in
                    
                    if error != nil {
                        print("Error: \(error!.localizedDescription)")
                        return
                    }
                    
                    if let uploadImageUrl = data?.downloadURL()?.absoluteString {
                        // 我們可以 print 出來看看這個連結事不是我們剛剛所上傳的照片。
                        print("Photo Url: \(uploadImageUrl)")
                    }
                })
            }
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
