//
//  MatrielViewController.swift
//  TravelDiary
//
//  Created by SIM1718 on 12/01/2020.
//  Copyright © 2020 Siddhant Mishra. All rights reserved.
//



import UIKit
import Alamofire
class MatrielViewController: UIViewController,UITableViewDataSource {
    
    
 //   @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var tableView: UITableView!
    var tvShows:NSArray = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fetchTvShows()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tvShows.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvShow")
        
        let contentView = cell?.viewWithTag(0)
        
        let tvShowImage = contentView?.viewWithTag(1) as! UIImageView
        
        let username = contentView?.viewWithTag(2) as! UILabel
        
        let phone = contentView?.viewWithTag(3) as! UILabel

        let nom = contentView?.viewWithTag(4) as! UILabel

        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
        
        username.text = tvShow["username"] as! String
        phone.text = tvShow["phone"] as! String
        nom.text =  tvShow["nom"] as! String
        if let image = getSavedImage(named: tvShow["img"] as! String) {
            // do something with image
            print("i got it ")
           tvShowImage.image = image
        }else{
            print("i dont get it")
        }
        
        return cell!
    }
    
    
    func fetchTvShows(){
        
        Alamofire.request("http://localhost:3000/showmatriel").responseJSON{ response in
            
            
            self.tvShows = response.result.value as! NSArray
            
            self.tableView.reloadData()
            
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
    

    
   
    

}

