//
//  AddJournalViewController.swift
//  Journal
//
//  Created by 黃珮鈞 on 2017/12/8.
//  Copyright © 2017年 黃珮鈞. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class AddJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var photoURL: String = ""
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
            let content = self.journalTextField.text
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
    
    //    MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
    {
        var selectedImageFromPicker: UIImage?
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = selectedImage
            imageView.image = selectedImage
            imageView.contentMode = .scaleAspectFit
        }
        let uniqueString = NSUUID().uuidString
        if let selectedImage = selectedImageFromPicker {
            
            let storageRef = Storage.storage().reference().child("Photos").child("\(uniqueString).png")
            
            if let uploadData = UIImagePNGRepresentation(selectedImage) {
                storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in
                    
                    if error != nil {
                        print("Error: \(error!.localizedDescription)")
                        return
                    }
                    
                    if let uploadImageUrl = data?.downloadURL()?.absoluteString {
                        self.photoURL = uploadImageUrl
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
