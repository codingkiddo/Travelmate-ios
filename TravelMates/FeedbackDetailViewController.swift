//
//  FeedbackDetailViewController.swift
//  TravelDiary
//
//  Created by SIM1718 on 11/01/2020.
//  Copyright © 2020 Siddhant Mishra. All rights reserved.
//

import UIKit
import Alamofire
class FeedbackDetailViewController: UIViewController {
    
   var idx = ""
   var datex = ""
   var depart = ""
   var destination = ""
   var eeeeee = ""
   var nbperss = ""
   var imagetrip = ""
   var iduser = ""
   var likes = "0"
   var dislikes = "0"
    
    @IBOutlet weak var ivtrip: UIImageView!
    
    @IBOutlet weak var tvdesc: UITextView!
    
    
    @IBOutlet weak var tfdesc: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvdesc.text = self.eeeeee
        if let image = getSavedImage(named: imagetrip) {
            // do something with image
            print("i got it ")
            ivtrip.image = image
        }else{
            print("i dont get it")
        }
    }
    
    //get image
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    //get image
    
    @IBAction func savefeedbackbtn(_ sender: Any) {
        var numstars = "5"
        var des = self.tfdesc.text
        let prefix = "http://localhost:3000/addfeedback?"
        let url1 = "stars="+numstars
        let url2 = "&description="+des!
        let url3 = "&idtrip="+self.idx
        Alamofire.request(prefix+url1+url2+url3).responseJSON{ response in
            
            let alert = UIAlertController(title: "Registration", message: "Registred!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert,animated: true,completion: nil)
            
        }
    }
    
    @IBAction func likebtn(_ sender: Any) {
        let likes = self.likes
        print(likes)
        let idtrip = self.idx
        Alamofire.request("http://localhost:3000/updatelikes?likes="+likes+"&id="+idtrip)
    }
    
    
    @IBAction func dislikebtn(_ sender: Any) {
        let dislikes = self.dislikes
        print(dislikes)
        let idtrip = self.idx
        Alamofire.request("http://localhost:3000/updatedislikes?dislikes="+dislikes+"&id="+idtrip)
    }
    
    
    @IBAction func reportbtn(_ sender: Any) {
        var tvvShows:NSArray = []
        Alamofire.request("http://localhost:3000/showtrips?depart=tunis").responseJSON{ response in
            tvvShows = response.result.value as! NSArray
            print(tvvShows.count)
            if(tvvShows.count > 3){
               Alamofire.request("http://localhost:3000/deletetrip?id="+self.idx)
                let alert = UIAlertController(title: "Report", message: "Trip Deleted Due to high number of reports!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert,animated: true,completion: nil)

            }else{
               Alamofire.request("http://localhost:3000/addreport?idtrip="+self.idx)
                let alert = UIAlertController(title: "Report", message: "Report added!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert,animated: true,completion: nil)

            }
    }
    
}
}
