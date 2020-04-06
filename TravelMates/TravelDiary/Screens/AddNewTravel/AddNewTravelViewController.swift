//
//  AddNewTravelViewController.swift
//  TravelDiary
//
//  Created by Siddhant Mishra on 11/02/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import DatePicker
import Alamofire

class AddNewTravelViewController: UIViewController {

    //MARK: - UI Elements
    @IBOutlet weak var coverImageBtn: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var VenueTextField: UITextField!
    @IBOutlet weak var DateTextField: UITextField!
    @IBOutlet weak var noOfPeople: UITextField!
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    var imagePicker = UIImagePickerController()
    let helper = HelperClass()
    var coverImage = UIImage()
    
    @IBOutlet weak var selectDateBtn: UIButton!

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
        
        addImageBtn.layer.borderColor = UIColor.init(displayP3Red: 52.0/255.0, green: 55.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        addImageBtn.layer.borderWidth = 0.5
        
    }
    
    func dismissVC() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
     //MARK: - Button Actions
    @IBAction func saveBtnAction(_ sender: Any) {
        if (titleTextField.text?.count)! > 0{
            if (selectDateBtn.titleLabel?.text!.count)! > 0 {
                self.SaveData()
                self.dismissVC()
            }
            else{
                helper.showAlert(Message: "Please select a valid date", ViewController: self)
            }
        }
        else{
            helper.showAlert(Message: "Please select a title", ViewController: self)
        }
        
    }
    
    
    @IBAction func addImageBtnAction(_ sender: Any) {
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
    
    @IBAction func backBtnAction(_ sender: Any) {
        dismissVC()
    }
    
    @IBAction func selectDateBtnAction(_ sender: Any) {
        self.resignAllResponser()
        let datePicker = DatePicker()
        datePicker.setup { (selected, date) in
            if selected, let selectedDate = date {
                self.selectDateBtn.setTitle(self.getSelectedDate(date: selectedDate as NSDate), for: UIControl.State.normal)
            } else {
                print("cancelled")
            }
        }
        datePicker.display(in: self)
    }
    
    func resignAllResponser() {
        titleTextField.resignFirstResponder()
        tagTextField.resignFirstResponder()
        VenueTextField.resignFirstResponder()
        noOfPeople.resignFirstResponder()
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
    func SaveData(){
        let fileURL = helper.saveImageToDocumentDirectory(coverImage, Name:helper.generateRowId())
        let x = saveImage(image: coverImage)
        print(x)

        var travelDict = [String:String]()
      //  travelDict["id"] = helper.generateRowId();
        travelDict["title"] = titleTextField.text
        travelDict["venue"] = VenueTextField.text
        travelDict["date"] = selectDateBtn.titleLabel?.text
        travelDict["noOfPeople"] = noOfPeople.text
        travelDict["tag"] = tagTextField.text
        if fileURL.count > 0 {
            travelDict["imagePath"] = fileURL
        }
        let randomInt = String(Int.random(in: 0..<6))
        let idCurrentuser = "12"
        let url = "http://localhost:3000/addtrip?iduser="+idCurrentuser
        let url2 = "&depart="+travelDict["tag"]!+"&destination="
        let url3 = travelDict["venue"]!+"&description="+travelDict["title"]!
        let url4 = "&nbpersonnes="+travelDict["noOfPeople"]!+"&imagetrip="+x+"&datexpiration="+travelDict["date"]!
        let fullurl = url+url2+url3+url4
        print(fullurl)
        Alamofire.request(fullurl)
            .responseJSON{ response in
                
                let alert = UIAlertController(title: "Sucess", message: "Trip Added !", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert,animated: true,completion: nil)
                
        }
    }
}

extension AddNewTravelViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.addImageBtn.setImage(editedImage, for: UIControl.State.normal)
            self.coverImage = editedImage
        }
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddNewTravelViewController : UITextFieldDelegate{

    func textFieldDidBeginEditing(_ textField: UITextField) {
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func getSelectedDate(date : NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date as Date)
        let selectedDate = formatter.date(from: dateString)
        formatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = formatter.string(from: selectedDate!)
        print(formattedDate)
        return formattedDate
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
            let randomInt = Int.random(in: 1...90, using: &rng)
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






