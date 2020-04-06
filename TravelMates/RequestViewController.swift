//
//  RequestViewController.swift
//  TravelDiary
//
//  Created by SIM1718 on 02/01/2020.
//  Copyright © 2020 Siddhant Mishra. All rights reserved.
//

import UIKit
import Alamofire


class RequestViewController: UIViewController {
    
    //MARK: - UIElements
    
 
    
    @IBOutlet weak var DetailCollectionView: UICollectionView!
    var helper = HelperClass()
    var travelArray = [[String:String]]()
    var tvShows:NSArray = []
    var Menu : [String] = ["Flight Booking","Hotel Booking","Gallery"]
    var imagetrip = ""
    
    //MARK: - View Setup1010
    override func viewDidLoad() {
        fetchTvShows()
        super.viewDidLoad()
    }
    
    //MARK: - Button Actions
    
  
    
  
}

extension RequestViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 14), height: CGFloat(213))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "travelRequestCell", for: indexPath);
        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
        helper.giveShadowToCollectionViewCell(cell: cell)
        let Image : UIImageView = cell.viewWithTag(1) as! UIImageView
        let title : UILabel = cell.viewWithTag(2) as! UILabel
        let destination : UILabel = cell.viewWithTag(7) as! UILabel

        title.text =  tvShow["status"] as! String
        var idtrip =  String(tvShow["idtrip"] as! Int)
        print("idtrip")
        print(idtrip)
       // Image.image = UIImage(named: "green-square-Retina")
        let response = Alamofire.request("http://localhost:3000/gettripbyid?id="+idtrip).responseJSON
        { response in
            let x = response.result.value as! NSDictionary
            self.imagetrip = x["imagetrip"] as! String
            destination.text = x["destination"] as! String
            print("imgtrip")
            print(self.imagetrip)
          //  Image.image = self.getSavedImage(named:self.imagetrip)

        }
        if( tvShow["status"] as! String == "waiting"){
            Image.image = UIImage(named: "Flight")
        }
        if( tvShow["status"] as! String == "accepted"){
            Image.image = UIImage(named: "checkmark")
        }
        if( tvShow["status"] as! String == "refused"){
            Image.image = UIImage(named: "forbidden")
        }
       
        return cell
    }
    
    //fetch data from db
    func fetchTvShows(){
        
        let defaults = UserDefaults.standard
        
        let yourValue = defaults.string(forKey: "idcurrentuser")

        Alamofire.request("http://localhost:3000/getsentrequest?sender="+yourValue!).responseJSON{ response in
            
            
            self.tvShows = response.result.value as! NSArray
            
            self.DetailCollectionView.reloadData()
            
        }
        
        
    }
    //fetch data from db
    
    //get image
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    //get image
}


