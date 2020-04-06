//
//  ViewController.swift
//  TravelDiary
//
//  Created by SIM1718 on 03/01/2020.
//  Copyright © 2020 Siddhant Mishra. All rights reserved.
//
import UIKit
import MapKit
import Alamofire

class ViewController: UIViewController , UISearchBarDelegate{
   
    
    @IBOutlet weak var MyMapView: MKMapView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    var tvShows:NSArray = []

    override func viewDidLoad() {
        
        //code taaa show location
        super.viewDidLoad()
   }
    
    
    
    @IBAction func happeningnow(_ sender: Any) {
        let sourceLocation = CLLocationCoordinate2D(latitude:36.806496 , longitude: 10.181532)
        let destinationLocation = CLLocationCoordinate2D(latitude:36.721420 , longitude: 10.216160)
        
        let sourcePin = customPin(pinTitle: "Tunis", pinSubTitle: "", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "Mourouj", pinSubTitle: "", location: destinationLocation)
        self.MyMapView.addAnnotation(sourcePin)
        self.MyMapView.addAnnotation(destinationPin)
        
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
            self.MyMapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.MyMapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
        
    @IBAction func searchbtn(_ sender: Any) {
        var destination = self.searchbar.text!; Alamofire.request("http://localhost:3000/gettripsbydestination?destination="+destination).responseJSON{ response in
            self.tvShows = response.result.value as! NSArray
            print(self.tvShows.count)
            var i = 0

            if(i != self.tvShows.count ){
                let tvShow = self.tvShows[i] as! Dictionary<String,Any>
                print("depart number i : ")
                print(tvShow["depart"] as! String)
                let searchRequest =  MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = tvShow["depart"] as! String
                let activeSearch = MKLocalSearch (request: searchRequest)
                activeSearch.start{(response , error) in
                    if response == nil
                    {
                        print("ERROR")
                    }
                    else
                        
                    {
                        let annotations = self.MyMapView.annotations
                        self.MyMapView.removeAnnotations(annotations)
                        let latitude = response?.boundingRegion.center.latitude
                        let longitude = response?.boundingRegion.center.longitude
                        
                        let annotation = MKPointAnnotation()
                        annotation.title = tvShow["depart"] as! String
                        annotation.coordinate=CLLocationCoordinate2DMake(latitude!, longitude!)
                        self.MyMapView.addAnnotation(annotation)
                        
                        
                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                        let span = MKCoordinateSpan.init(latitudeDelta: 0.1,longitudeDelta: 0.1)
                        let region = MKCoordinateRegion.init(center: coordinate,span: span)
                        self.MyMapView.setRegion(region, animated: true)
                        var x = true
                        
                        
                    }
                    //code taaa show location
                }
            }
            i = i+1
            if(i != self.tvShows.count ){
                let tvShow = self.tvShows[i] as! Dictionary<String,Any>
                print("depart number i : ")
                print(tvShow["depart"] as! String)
                let searchRequest =  MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = tvShow["depart"] as! String
                let activeSearch = MKLocalSearch (request: searchRequest)
                activeSearch.start{(response , error) in
                    if response == nil
                    {
                        print("ERROR")
                    }
                    else
                        
                    {
                        let annotations = self.MyMapView.annotations
                        self.MyMapView.removeAnnotations(annotations)
                        let latitude = response?.boundingRegion.center.latitude
                        let longitude = response?.boundingRegion.center.longitude
                        
                        let annotation = MKPointAnnotation()
                        annotation.title = tvShow["depart"] as! String
                        annotation.coordinate=CLLocationCoordinate2DMake(latitude!, longitude!)
                        self.MyMapView.addAnnotation(annotation)
                        
                        
                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                        let span = MKCoordinateSpan.init(latitudeDelta: 0.1,longitudeDelta: 0.1)
                        let region = MKCoordinateRegion.init(center: coordinate,span: span)
                        self.MyMapView.setRegion(region, animated: true)
                        var x = true
                        
                        
                    }
                    //code taaa show location
                }
            }
            
            i = i+1
            if(i != self.tvShows.count ){
                let tvShow = self.tvShows[i] as! Dictionary<String,Any>
                print("depart number i : ")
                print(tvShow["depart"] as! String)
                let searchRequest =  MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = tvShow["depart"] as! String
                let activeSearch = MKLocalSearch (request: searchRequest)
                activeSearch.start{(response , error) in
                    if response == nil
                    {
                        print("ERROR")
                    }
                    else
                        
                    {
                        let annotations = self.MyMapView.annotations
                        self.MyMapView.removeAnnotations(annotations)
                        let latitude = response?.boundingRegion.center.latitude
                        let longitude = response?.boundingRegion.center.longitude
                        
                        let annotation = MKPointAnnotation()
                        annotation.title = tvShow["depart"] as! String
                        annotation.coordinate=CLLocationCoordinate2DMake(latitude!, longitude!)
                        self.MyMapView.addAnnotation(annotation)
                        
                        
                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                        let span = MKCoordinateSpan.init(latitudeDelta: 0.1,longitudeDelta: 0.1)
                        let region = MKCoordinateRegion.init(center: coordinate,span: span)
                        self.MyMapView.setRegion(region, animated: true)
                        var x = true
                        
                        
                    }
                    //code taaa show location
                }
            }
            
            
            i = i+1
            if(i != self.tvShows.count ){
                let tvShow = self.tvShows[i] as! Dictionary<String,Any>
                print("depart number i : ")
                print(tvShow["depart"] as! String)
                let searchRequest =  MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = tvShow["depart"] as! String
                let activeSearch = MKLocalSearch (request: searchRequest)
                activeSearch.start{(response , error) in
                    if response == nil
                    {
                        print("ERROR")
                    }
                    else
                        
                    {
                        let annotations = self.MyMapView.annotations
                        self.MyMapView.removeAnnotations(annotations)
                        let latitude = response?.boundingRegion.center.latitude
                        let longitude = response?.boundingRegion.center.longitude
                        
                        let annotation = MKPointAnnotation()
                        annotation.title = tvShow["depart"] as! String
                        annotation.coordinate=CLLocationCoordinate2DMake(latitude!, longitude!)
                        self.MyMapView.addAnnotation(annotation)
                        
                        
                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                        let span = MKCoordinateSpan.init(latitudeDelta: 0.1,longitudeDelta: 0.1)
                        let region = MKCoordinateRegion.init(center: coordinate,span: span)
                        self.MyMapView.setRegion(region, animated: true)
                        var x = true
                        
                        
                    }
                    //code taaa show location
                }
            }
            
            
            i = i+1
            if(i != self.tvShows.count ){
                let tvShow = self.tvShows[i] as! Dictionary<String,Any>
                print("depart number i : ")
                print(tvShow["depart"] as! String)
                let searchRequest =  MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = tvShow["depart"] as! String
                let activeSearch = MKLocalSearch (request: searchRequest)
                activeSearch.start{(response , error) in
                    if response == nil
                    {
                        print("ERROR")
                    }
                    else
                        
                    {
                        let annotations = self.MyMapView.annotations
                        self.MyMapView.removeAnnotations(annotations)
                        let latitude = response?.boundingRegion.center.latitude
                        let longitude = response?.boundingRegion.center.longitude
                        
                        let annotation = MKPointAnnotation()
                        annotation.title = tvShow["depart"] as! String
                        annotation.coordinate=CLLocationCoordinate2DMake(latitude!, longitude!)
                        self.MyMapView.addAnnotation(annotation)
                        
                        
                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                        let span = MKCoordinateSpan.init(latitudeDelta: 0.1,longitudeDelta: 0.1)
                        let region = MKCoordinateRegion.init(center: coordinate,span: span)
                        self.MyMapView.setRegion(region, animated: true)
                        var x = true
                        
                        
                    }
                    //code taaa show location
                }
            }
            
            
            i = i+1
            if(i != self.tvShows.count ){
                let tvShow = self.tvShows[i] as! Dictionary<String,Any>
                print("depart number i : ")
                print(tvShow["depart"] as! String)
                let searchRequest =  MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = tvShow["depart"] as! String
                let activeSearch = MKLocalSearch (request: searchRequest)
                activeSearch.start{(response , error) in
                    if response == nil
                    {
                        print("ERROR")
                    }
                    else
                        
                    {
                        let annotations = self.MyMapView.annotations
                        self.MyMapView.removeAnnotations(annotations)
                        let latitude = response?.boundingRegion.center.latitude
                        let longitude = response?.boundingRegion.center.longitude
                        
                        let annotation = MKPointAnnotation()
                        annotation.title = tvShow["depart"] as! String
                        annotation.coordinate=CLLocationCoordinate2DMake(latitude!, longitude!)
                        self.MyMapView.addAnnotation(annotation)
                        
                        
                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                        let span = MKCoordinateSpan.init(latitudeDelta: 0.1,longitudeDelta: 0.1)
                        let region = MKCoordinateRegion.init(center: coordinate,span: span)
                        self.MyMapView.setRegion(region, animated: true)
                        var x = true
                        
                        
                    }
                    //code taaa show location
                    
                    i = i+1
                    if(i != self.tvShows.count ){
                        let tvShow = self.tvShows[i] as! Dictionary<String,Any>
                        print("depart number i : ")
                        print(tvShow["depart"] as! String)
                        let searchRequest =  MKLocalSearch.Request()
                        searchRequest.naturalLanguageQuery = tvShow["depart"] as! String
                        let activeSearch = MKLocalSearch (request: searchRequest)
                        activeSearch.start{(response , error) in
                            if response == nil
                            {
                                print("ERROR")
                            }
                            else
                                
                            {
                                let annotations = self.MyMapView.annotations
                                self.MyMapView.removeAnnotations(annotations)
                                let latitude = response?.boundingRegion.center.latitude
                                let longitude = response?.boundingRegion.center.longitude
                                
                                let annotation = MKPointAnnotation()
                                annotation.title = tvShow["depart"] as! String
                                annotation.coordinate=CLLocationCoordinate2DMake(latitude!, longitude!)
                                self.MyMapView.addAnnotation(annotation)
                                
                                
                                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                                let span = MKCoordinateSpan.init(latitudeDelta: 0.1,longitudeDelta: 0.1)
                                let region = MKCoordinateRegion.init(center: coordinate,span: span)
                                self.MyMapView.setRegion(region, animated: true)
                                var x = true
                                
                                
                            }
                            //code taaa show location
                            
                            i = i+1
                            if(i != self.tvShows.count ){
                                let tvShow = self.tvShows[i] as! Dictionary<String,Any>
                                print("depart number i : ")
                                print(tvShow["depart"] as! String)
                                let searchRequest =  MKLocalSearch.Request()
                                searchRequest.naturalLanguageQuery = tvShow["depart"] as! String
                                let activeSearch = MKLocalSearch (request: searchRequest)
                                activeSearch.start{(response , error) in
                                    if response == nil
                                    {
                                        print("ERROR")
                                    }
                                    else
                                        
                                    {
                                        let annotations = self.MyMapView.annotations
                                        self.MyMapView.removeAnnotations(annotations)
                                        let latitude = response?.boundingRegion.center.latitude
                                        let longitude = response?.boundingRegion.center.longitude
                                        
                                        let annotation = MKPointAnnotation()
                                        annotation.title = tvShow["depart"] as! String
                                        annotation.coordinate=CLLocationCoordinate2DMake(latitude!, longitude!)
                                        self.MyMapView.addAnnotation(annotation)
                                        
                                        
                                        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                                        let span = MKCoordinateSpan.init(latitudeDelta: 0.1,longitudeDelta: 0.1)
                                        let region = MKCoordinateRegion.init(center: coordinate,span: span)
                                        self.MyMapView.setRegion(region, animated: true)
                                        var x = true
                                        
                                        
                                    }
                                    //code taaa show location
                }
            }
            
                            
            
            
           
    }
    
    }
}
    ///////
    
}

}

}
}
