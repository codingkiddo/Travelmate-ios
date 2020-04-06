//
//  TravelDetailViewController.swift
//  TravelDiary
//
//  Created by Siddhant Mishra on 20/02/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import Alamofire

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}


class TravelDetailViewController: UIViewController,MKMapViewDelegate {

    //MARK: - UIElements
    
    @IBOutlet weak var CoverPicture: UIImageView!
    @IBOutlet weak var tripName: UILabel!
    @IBOutlet weak var tripDate: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var editBtnAction: UIButton!
 //   @IBOutlet weak var DetailCollectionView: UICollectionView
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var BackBtn: UIButton!
    
    @IBOutlet weak var SendRequest: UIButton!
    
    var helper = HelperClass()
    var travelArray = [[String:String]]()
    var Menu : [String] = ["Request Trip","Send Message","Report Trip"]
    var depart : String = ""
    var destination : String = ""
    var dateexpiration : String = ""
    var nbpersonnes : String = ""
    var idtrip = ""
    var idowner = ""
    //MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        let dashVC = DashBoardViewController()
        dashVC.travelDetail = self
        let sourceLocation = CLLocationCoordinate2D(latitude:39.173209 , longitude: -94.593933)
        let destinationLocation = CLLocationCoordinate2D(latitude:38.643172 , longitude: -90.177429)
        
        let sourcePin = customPin(pinTitle: "Départ", pinSubTitle: "", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "Destination", pinSubTitle: "", location: destinationLocation)
        self.mapView.addAnnotation(sourcePin)
        self.mapView.addAnnotation(destinationPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            
            let route = directionResonse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
        self.mapView.delegate = self

    }
    //MARK:- MapKit delegates
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    //MARK: - Button Actions
    
    @IBAction func BackBtnAction(_ sender: Any) {
        self.dismissVC()
    }
    
    
  /*  @IBAction func btnPressed(_ sender: Any) {
    }*/
    
    
    @IBAction func SendBtnAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        let yourValue = defaults.string(forKey: "idcurrentuser")

        var url = "http://localhost:3000/addrequest?sender="+yourValue!+"&receiver="+self.idowner+"&status=waiting&idtrip="+self.idtrip
        Alamofire.request(url
            )
            .responseJSON{ response in
                print(url)
                let alert = UIAlertController(title: "Request", message: "Request Sent !", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert,animated: true,completion: nil)
                
        }
    }
    
    func dismissVC() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

/*extension TravelDetailViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
   /* func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 14), height: CGFloat(213))
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "travelDetailCell", for: indexPath);
        
        helper.giveShadowToCollectionViewCell(cell: cell)
        let Image : UIImageView = cell.viewWithTag(1) as! UIImageView
        let title : UILabel = cell.viewWithTag(2) as! UILabel
        
        if Menu[indexPath.row] == "Request Trip"{
            Image.image = #imageLiteral(resourceName: "Flight")
        }
        else if Menu[indexPath.row] == "Send Message"{
            Image.image = #imageLiteral(resourceName: "Hotel")
        }
        else if Menu[indexPath.row] == "Report Trip"{
            Image.image = #imageLiteral(resourceName: "Gallery")
        }
        title.text = Menu[indexPath.row]
        return cell
    }*/
}*/

extension TravelDetailViewController: TravelDetail{
    
    func travelRecordTapped(idtrip:String,depart:String,destination:String,date:String,idowner:String,nbpersonnes:String,imagetrip:String,description:String){
        let image = getSavedImage(named: imagetrip as! String)
        CoverPicture.image = image
        var txt = "Nombre de personnes: "
        tripName.text = description
        tripDate.text = txt+nbpersonnes
        self.idowner = idowner
        self.idtrip = idtrip
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
