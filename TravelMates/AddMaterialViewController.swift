//
//  AddMaterialViewController.swift
//  TravelDiary
//
//  Created by SIM1718 on 12/01/2020.
//  Copyright © 2020 Siddhant Mishra. All rights reserved.
//



import UIKit
import DatePicker
import Alamofire

class AddMaterialViewController: UIViewController {
    
    //MARK: - UI Elements
    
  //  @IBOutlet weak var coverImageBtn: UIButton!
    
    
    @IBOutlet weak var coverImageBtn: UIButton!
    @IBOutlet weak var formView: UIView!
    
    
    @IBOutlet weak var Nom: UITextField!
    
    
    @IBOutlet weak var MatrielName: UITextField!
    
    
    @IBOutlet weak var Phone: UITextField!
    
    
 
    
    
  //  @IBOutlet weak var coverImageBtn: UIButton!
    
  //  @IBOutlet weak var formView: UIView!
    
    var imagePicker = UIImagePickerController()
    let helper = HelperClass()
    var coverImage = UIImage()
    
   // @IBOutlet weak var selectDateBtn: UIButton!
    
    //MARK: - View Setup Functions
    override func viewDidLoad() {
        self.UIElementSetup()
        super.viewDidLoad()
    }
    
    func UIElementSetup() {
        
        // Setup for UI Elements
        formView.layer.borderColor = UIColor.lightGray.cgColor
        formView.layer.borderWidth = 0.5
        formView.layer.cornerRadius = 10.0
        
        
    }
    
    func dismissVC() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    //MARK: - Button Actions

    
    


    @IBAction func addItemImage(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }
    
    

 
    
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Open the gallery
    func openGallery(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - API Requests
    
    
    @IBAction func AjouterMatrielBtnClicked(_ sender: Any) {
        var nom = self.Nom.text
        var matrielName = self.MatrielName.text
        var phone = self.Phone.text
        var matrielimg = self.coverImageBtn.imageView
        var fulname = saveImage(image: coverImage)
        print("saved image name "+fulname)
        print(nom! + matrielName! + phone! )
        var url1 = "http://localhost:3000/addmatriel?nom="
        var url2 = fulname+"&username="+nom!+"&phone="
        Alamofire.request(url1+matrielName!+"&img="+url2+phone!)
    }
    
    

}

extension AddMaterialViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.coverImageBtn.setImage(editedImage, for: UIControl.State.normal)
            self.coverImage = editedImage
            
        }
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddMaterialViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
   
    
    func saveImage(image: UIImage) -> String {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return "fullname"
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return "fullname"
        }
        do {
            var rng = SystemRandomNumberGenerator()
            let randomInt = Int.random(in: 1...6, using: &rng)
            let filname = "fileName"
            let extensionimg = ".png"
            let fullname = filname+String(randomInt)+extensionimg
            print(fullname)
            try data.write(to: directory.appendingPathComponent(fullname)!)
            return filname+String(randomInt)
        } catch {
            print(error.localizedDescription)
            return "ullname"
        }
    }
    
}
