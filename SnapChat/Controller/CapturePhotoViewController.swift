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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate   = self
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.configureNextButton()
    }
    
    @IBAction func selectionPhotoAction(_ sender: Any) {
        
        self.configureImagePicker()
    }
    
    func configureNextButton() {
        self.nextButton.isEnabled = false
        self.nextButton.setTitle("Carregando...", for: .normal)
        
        self.uploadProfileImage()
    }
    
    func uploadProfileImage() {
        let storage = Storage.storage().reference()
        let images  = storage.child("images")
        
        if let selectedImage = photoImageView.image {
            if let dataImage = selectedImage.jpegData(compressionQuality: 0.75) {
                images.child("image.jpg").putData(dataImage, metadata: nil, completion: {(metaData, error) in
                    if error == nil {
                        print("Sucesso")
                        self.nextButton.isEnabled = true
                        self.nextButton.setTitle("Próximo", for: .normal)
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
        imagePicker.sourceType = .photoLibrary
        
        self.presentFullScreen(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let retrievedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.photoImageView.image = retrievedImage
        
        self.imagePicker.dismiss(animated: true, completion: nil)
    }
}
