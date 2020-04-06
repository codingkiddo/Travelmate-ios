//
//  ChatroomsViewController.swift
//  TravelDiary
//
//  Created by SIM1718 on 14/01/2020.
//  Copyright © 2020 Siddhant Mishra. All rights reserved.
//

import UIKit
import Alamofire
class MessagesViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    var idgroup =  ""
   // @IBOutlet weak var tableView: UITableView!
  
    
    @IBOutlet weak var msgtf: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tvShows:NSArray = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fetchTvShows()
        
        let defaults = UserDefaults.standard
        
        let yourValue = defaults.string(forKey: "idcurrentuser")
        
        print("idcurrentuser"+yourValue!)

        
    }
    
    
    
    @IBAction func sendtext(_ sender: Any) {
        let idg = self.idgroup
        let defaults = UserDefaults.standard
        
        let yourValue = defaults.string(forKey: "idcurrentuser")
        let sender = yourValue
        
        let msg = msgtf.text
        let url = "&sender=" + sender!
        let url2 = "&idgroup="+idg
        Alamofire.request("http://localhost:3000/addtextos?msg="+msg!+url+url2)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tvShows.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagecell")
        
        let contentView = cell?.viewWithTag(0)
        
        
        let username = contentView?.viewWithTag(1) as! UITextView
        
        let esmeluser = contentView?.viewWithTag(5) as! UILabel

        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
        
        
        ////get user info here
        let defaults = UserDefaults.standard
        
        let yourValue = tvShow["sender"] as! String

        Alamofire.request("http://localhost:3000/getuserbyid?id="+yourValue).responseJSON{ response in
            let x = response.result.value as! NSDictionary
            let idcurrentuser = x["imagetrip"]!
            let loginstatus = x["LoginStatus"] as! String
            esmeluser.text = idcurrentuser as! String
        }
        /// get user info here
        username.text = tvShow["msg"] as! String
        
        
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("dddddddd")
        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
        
        var idgroup = tvShow["idgroup"] as! Int
        var idx = "\(idgroup)"
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MessagesViewController") as? MessagesViewController
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    
    func fetchTvShows(){
        print(self.idgroup)
        Alamofire.request("http://localhost:3000/showtextos?id="+self.idgroup).responseJSON{ response in
            
            
            self.tvShows = response.result.value as! NSArray
            
            self.tableView.reloadData()
            
        }
        
        
    }
    
}

