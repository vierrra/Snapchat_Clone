//
//  CapturePhotoViewController.swift
//  SnapChat
//
//  Created by Renato Vieira on 6/11/21.
//

import UIKit
import FirebaseStorage

class CapturePhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView:            UIImageView!
    @IBOutlet weak var descriptionPhotoTextField: UITextField!
    @IBOutlet weak var nextButton:                UIButton!
    
    var imagePicker = UIImagePickerController()
    var idImage     = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureDisableSendButton()
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        self.configureSendButton()
    }
    
    @IBAction func selectionPhotoAction(_ sender: Any) {
        
        self.configureImagePicker()
    }
    
    func configureSendButton() {
        self.nextButton.isEnabled = false
        self.nextButton.setTitle("Carregando...", for: .normal)
        
        self.uploadProfileImage()
    }
    
    func configureDisableSendButton() {
        self.nextButton.isEnabled = false
        self.nextButton.backgroundColor = .lightGray
    }
    
    func configureActiveSendButton() {
        self.nextButton.isEnabled = true
        self.nextButton.backgroundColor = .systemBlue
    }
    
    func uploadProfileImage() {
        let storage = Storage.storage().reference()
        let images  = storage.child("images")
        
        if let selectedImage = photoImageView.image {
            if let dataImage = selectedImage.jpegData(compressionQuality: 0.1) {
                images.child("\(self.idImage).jpg").putData(dataImage, metadata: nil, completion: {(metaData, error) in
                    if error == nil {
                        print("Sucesso")
                        self.nextButton.isEnabled = true
                        self.nextButton.setTitle("Enviar", for: .normal)
                    } else {
                        print("Falha")
                    }
                })
            }
        }
    }
}

extension CapturePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func configureImagePicker() {
        imagePicker.delegate    = self
        imagePicker.sourceType = .photoLibrary
        
        self.presentFullScreen(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let retrievedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.photoImageView.image = retrievedImage
        
        self.imagePicker.dismiss(animated: true, completion: nil)
        self.configureActiveSendButton()
    }
}
