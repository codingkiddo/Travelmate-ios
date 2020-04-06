//
//  ViewController.swift
//  TravelDiary
//
//  Created by Siddhant Mishra on 27/01/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import CoreData
import SideMenu
import Alamofire

protocol TravelDetail {
    func travelRecordTapped(idtrip:String,depart:String,destination:String,date:String,idowner:String,nbpersonnes:String,imagetrip:String,description:String)
}

class DashBoardViewController: UIViewController {

    @IBOutlet weak var TopBar: UIView!
    @IBOutlet weak var NoRecordPlaceholder: UIView!
    @IBOutlet weak var TravelListView: UITableView!
    @IBOutlet weak var departlabel: UILabel!
    let helper = HelperClass()
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var travelArray = [NSManagedObject]()
    var travelDetail : TravelDetailViewController!
    var tvShows:NSArray = []

    //MARK: - View Setup
    override func viewDidLoad() {
        fetchTvShows()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        travelArray = helper.queryAllData(entity: "Travels")
        if travelArray.count == 0{
            NoRecordPlaceholder.isHidden = false
        }
        else{
            NoRecordPlaceholder.isHidden = true
        }
        self .TravelListView.reloadData()
        super.viewDidAppear(true)
    }
    
    //MARK: - Button Actions
    @IBAction func addNewTravel(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddNewTravel")
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
 
    
    
    
    @IBAction func MenuBtnAction(_ sender: Any) {
    }
    
}

extension DashBoardViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath);
        helper.giveShadowToTableViewCell(cell: cell)
        
        let coverImage : UIImageView = cell.viewWithTag(3) as! UIImageView
        let title : UILabel = cell.viewWithTag(1) as! UILabel
        let date : UILabel = cell.viewWithTag(2) as! UILabel
        let destination : UILabel = cell.viewWithTag(10) as! UILabel

       //get data
        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
         title.text = tvShow["depart"] as! String
        destination.text = tvShow["destination"] as? String
         date.text = tvShow["datexpiration"] as! String
        //get data
        
   
        if let image = getSavedImage(named: tvShow["imagetrip"] as! String) {
            // do something with image
            print("i got it ")
            coverImage.image = image
            coverImage.layer.cornerRadius = coverImage.frame.width / 2
        }else{
            print("i dont get it")
        }
      
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TravelDetail")
        self.travelDetail = vc as? TravelDetailViewController
        print(indexPath.row)
        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
        
        let id = tvShow["id"] as? Int
        let datexpiration = tvShow["datexpiration"] as? String
        let depart = tvShow["depart"] as? String
        let destination = tvShow["destination"] as? String
        let nbpersonnes = tvShow["nbpersonnes"] as? String
        let imagetrip = tvShow["imagetrip"] as? String
        let description = tvShow["description"] as? String
        let iduser = tvShow["iduser"] as? Int
        
        // let img =   getSavedImage(named: tvShow["image"] as! String)
        let image = #imageLiteral(resourceName: "munnar")
        self.present(vc, animated: true, completion: nil)
       
        var idx = "\(id!)"
        var iduserx = "\(iduser!)"

        print("idx:")
         print(idx)
        print("datex:")
         print(datexpiration!)
        print("depart :")
         print(depart!)
        print("destination")
         print(destination!)
        print("nbperss :")
         print(nbpersonnes!)
        print("imagetrip")
         print(imagetrip!)
        print("iduser : ")
        print(iduserx)

        travelDetail?.travelRecordTapped(idtrip:idx,depart:depart!,destination:destination!,date:datexpiration!,idowner:iduserx,nbpersonnes:nbpersonnes!,imagetrip:imagetrip!,description:description!)

      /*    else{
         let image = #imageLiteral(resourceName: "munnar")
         self.present(vc, animated: true, completion: nil)
         travelDetail?.travelRecordTapped(id: id!, image: image, title: title!, date: date!)
         }   */
        
  

        
         
    }
    //fetch data from db
    func fetchTvShows(){
        
        Alamofire.request("http://localhost:3000/showtrips?depart=tunis").responseJSON{ response in
            
            
            self.tvShows = response.result.value as! NSArray
            
            self.TravelListView.reloadData()
            
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
