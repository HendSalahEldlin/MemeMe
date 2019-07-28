//
//  ViewController.swift
//  MeMe1.0
//
//  Created by Hend  on 5/21/19.
//  Copyright © 2019 Hend . All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var activeTextField = UITextField()
    var meme:Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        let shareBtn = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(btnShare_clicked))
        self.navigationItem.leftBarButtonItem = shareBtn
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(btnCancel_clicked))
        self.navigationItem.rightBarButtonItem = cancelBtn
        configureTextField(topTextField, text: "TOP")
        configureTextField(bottomTextField, text:"BOTTOM")
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    
    
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sender == cameraBtn ? .camera : .photoLibrary
        present(pickerController, animated: true, completion: nil)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            dismiss(animated: true, completion: nil)
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        self.navigationController?.navigationBar.isHidden = true
        toolBar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // Show toolbar and navbar
        self.navigationController?.navigationBar.isHidden = false
        toolBar.isHidden = false
        return memedImage
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)

        UIImageWriteToSavedPhotosAlbum(meme.memedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func btnShare_clicked() {
        let memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        self.present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success{
                self.save()
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @objc func btnCancel_clicked() {
        //dismiss(animated: false, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

