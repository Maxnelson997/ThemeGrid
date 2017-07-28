//
//  CameraController.swift
//  colormeapp
//
//  Created by Max Nelson on 5/22/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit


class CameraController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var singleton = MainSingleton.sharedInstance
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    
//    
//    var button:UIButton = {
//        var b = UIButton()
//        b.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
//        b.layer.cornerRadius = 12
//        b.layer.masksToBounds = true
//        b.translatesAutoresizingMaskIntoConstraints = false
//        return b
//    }()
//    
//    var library:UIButton = {
//        var b = UIButton()
//        b.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
//        b.layer.cornerRadius = 12
//        b.layer.masksToBounds = true
//        b.translatesAutoresizingMaskIntoConstraints = false
//        return b
//    }()

    override func viewDidAppear(_ animated: Bool) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
//            imagePicker.allowsEditing = true
//            imagePicker.showsCameraControls = true
//            self.present(imagePicker, animated: true, completion: nil)
//        }


                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                    imagePicker.allowsEditing = false
        
                    self.present(imagePicker, animated: true, completion: nil)
                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.addSubview(button)
//        view.addSubview(library)
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            button.widthAnchor.constraint(equalToConstant: 200),
//            button.heightAnchor.constraint(equalToConstant: 40),
////            
//            library.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            library.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
//            library.widthAnchor.constraint(equalToConstant: 200),
//            library.heightAnchor.constraint(equalToConstant: 40)
//            ])
        
//        button.setTitle("Take a pic", for: .normal)
//        button.addTarget(self, action: #selector(self.take_pic), for: .touchUpInside)
        
//        library.setTitle("Pick a pic", for: .normal)
//        library.addTarget(self, action: #selector(self.photoPressed), for: .touchUpInside)
    }
//    
//    func take_pic() {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
//            imagePicker.allowsEditing = true
//            imagePicker.showsCameraControls = true
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: {
            
            
        })
        picker.dismiss(animated: true, completion: nil)
        self.appDelegate.goToGrid()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //save the selected or taken image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        //getting details of image
//        let uploadFileURL = info[UIImagePickerControllerReferenceURL] as! NSURL
//        
//        let imageName = uploadFileURL.lastPathComponent
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
//        
//        // getting local path
//        let localPath = (documentDirectory as NSString).appendingPathComponent(imageName!)
//        
//        
//        //getting actual image
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let data = UIImagePNGRepresentation(image)
//        
//        do {
//            try data!.write(to: URL(fileURLWithPath: localPath))
//        }
//        catch {
//            print(error)
//        }
//        
        if let img = info[UIImagePickerControllerEditedImage] as? UIImage {
            singleton.images.insert(img, at: 0)
//            singleton.upload_image(imageURL:NSURL(fileURLWithPath: localPath))

        }
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            singleton.images.insert(img, at: 0)
//            singleton.upload_image(imageURL:NSURL(fileURLWithPath: localPath))
        }
        
        self.dismiss(animated: true, completion: {

            
        })
        picker.dismiss(animated: true, completion: nil)
        self.appDelegate.goToGrid()
    }
    
//    func photoPressed() {
//        
//        //go to camera roll. Select a photo. Then go to EditPhoto
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePicker.allowsEditing = false
//            
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//        
//    }
    
    
}
