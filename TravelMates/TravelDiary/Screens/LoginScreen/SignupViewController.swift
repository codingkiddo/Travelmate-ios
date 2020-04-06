//
//  SignupViewController.swift
//  TravelDiary
//
//  Created by SIM1718 on 19/12/2019.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
class SignupViewController: UIViewController {

   
    @IBOutlet weak var signupview: UIView!
    
    @IBOutlet weak var loginMasterView: UIView!
    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var confirmpassword: UITextField!

    @IBOutlet weak var PasswordTextfield: UITextField!
    
    var window: UIWindow?
let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var player: AVPlayer?
    let videoURL: NSURL = Bundle.main.url(forResource: "Aerial", withExtension: "mp4")! as NSURL
    override func viewDidLoad() {
        self.view.bringSubviewToFront(signupview)
        super.viewDidLoad()

        loginMasterView.alpha = 0.0;
        loginMasterView.layer.zPosition = 0;
        
        player = AVPlayer(url: videoURL as URL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.frame = view.frame
        view.layer.addSublayer(playerLayer)
        player?.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
       
        
    }
    
    
    
    @IBAction func signupBtnClicked(_ sender: Any) {
        
        let name = NameTextField.text
        let password =  PasswordTextfield.text
        let confirmpassword =  PasswordTextfield.text
        print(name)
        if(name != "yassine"){
        if(password == confirmpassword){
        print("http://localhost:3000/register?name="+name!+"&password="+password!)
        Alamofire.request("http://localhost:3000/register?name="+name!+"&password="+password!).responseJSON{ response in
            
            let alert = UIAlertController(title: "Registration", message: "Registred!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert,animated: true,completion: nil)
      
            
            
        }
            
        }else{
            let alert = UIAlertController(title: "ERROR", message: "PASSWORD DON'T MATCH", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert,animated: true,completion: nil)
        }
        }else{
            let alert = UIAlertController(title: "ERROR", message: "Username Not Available", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert,animated: true,completion: nil)

        }
    }
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
