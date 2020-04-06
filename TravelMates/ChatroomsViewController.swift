//
//  ChatroomsViewController.swift
//  TravelDiary
//
//  Created by SIM1718 on 14/01/2020.
//  Copyright © 2020 Siddhant Mishra. All rights reserved.
//

import UIKit
import Alamofire
class ChatroomsViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupcell")
        
        let contentView = cell?.viewWithTag(0)
        
        
        let username = contentView?.viewWithTag(1) as! UILabel
        
        
        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
        
        username.text = tvShow["nom"] as! String

        
        return cell!
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("dddddddd")
        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
        
        var idgroup = tvShow["idgroup"] as! Int
        var idx = "\(idgroup)"
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MessagesViewController") as? MessagesViewController
        vc?.idgroup = idx
        self.present(vc!, animated: true, completion: nil)

    }

    
    func fetchTvShows(){
        
        Alamofire.request("http://localhost:3000/showgroupet").responseJSON{ response in
            
            
            self.tvShows = response.result.value as! NSArray
            
            self.tableView.reloadData()
            
        }
        
        
    }
    
}

