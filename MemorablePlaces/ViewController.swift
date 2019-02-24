//
//  ViewController.swift
//  MemorablePlaces
//
//  Created by IMCS2 on 2/23/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import MapKit
import UIKit


class ViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet var map: MKMapView!
    
    
    var coord = CLLocationCoordinate2D(latitude: 0,longitude: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEWDIDLOAD VC")
       print("LAtitude"); print(UserDefaults.standard.value(forKey: "latitude"))
        print("Longitude"); print(UserDefaults.standard.value(forKey: "longitude"))
        print("Title"); print(UserDefaults.standard.value(forKey: "title"))
        print("subtitle"); print(UserDefaults.standard.value(forKey: "subtitle"))
        
        
        var i = 0
        
        if let check = UserDefaults.standard.value(forKey: "title") as? Array<String?>{
        //print("Check : \(check ?? 0)")
            if(check.count == 0 )
            {
                
                let latitude : CLLocationDegrees = 32.840744
                let longitude : CLLocationDegrees = -96.994970
                let latDelta: CLLocationDegrees = 0.05
                let longDelta : CLLocationDegrees = 0.05
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
                let region = MKCoordinateRegion(center: coordinates, span: span)
                
                map.setRegion(region, animated: true)
                
                //Adding Annotation
                //            let annotation = MKPointAnnotation()
                //            annotation.title = UserDefaults.standard.value(forKey:"title") as? String
                //            annotation.subtitle = UserDefaults.standard.value(forKey: "subtitle") as? String
                //            annotation.coordinate = coordinates
                //            map.addAnnotation(annotation)
                //
                //Adding long press gesture
                
                let uiLongPress = UILongPressGestureRecognizer(target: self, action:#selector(self.longPressAction(gustureRecognizer:)))
                uiLongPress.minimumPressDuration = 1.0
                map.addGestureRecognizer(uiLongPress)
                
            }
                
            else{
                // Do any additional setup after loading the view, typically from a nib.
                while(i < (check.count )) {
                    let la = (UserDefaults.standard.value(forKey: "latitude") as? [CLLocationDegrees])!
                    let lo = (UserDefaults.standard.value(forKey: "longitude") as? [CLLocationDegrees])!
                    let latitude : CLLocationDegrees = la[i]
                    let longitude : CLLocationDegrees = lo[i]
                    let latDelta: CLLocationDegrees = 0.08
                    let longDelta : CLLocationDegrees = 0.08
                    let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
                    let region = MKCoordinateRegion(center: coordinates, span: span)
                    
                    map.setRegion(region, animated: true)
                    
                    
                    let t = UserDefaults.standard.value(forKey:"title") as? [String]
                    let s = UserDefaults.standard.value(forKey:"subtitle") as? [String]
                    //Adding Annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = t?[i]
                    annotation.subtitle = s?[i]
                    annotation.coordinate = coordinates
                    map.addAnnotation(annotation)
                    
                    //Adding long press gesture
                    
                    let uiLongPress = UILongPressGestureRecognizer(target: self, action:#selector(self.longPressAction(gustureRecognizer:)))
                    uiLongPress.minimumPressDuration = 1.0
                    map.addGestureRecognizer(uiLongPress)
                    i+=1
                }
                
                
            }
        }
        }
       

    @objc func longPressAction(gustureRecognizer: UIGestureRecognizer){
        let touchPoint = gustureRecognizer.location(in: self.map)
        let coordinates = map.convert(touchPoint, toCoordinateFrom: self.map)
        let annotation = MKPointAnnotation()
        annotation.title = "NewLongPress"
        annotation.subtitle = "LongPressGesture"
        annotation.coordinate = coordinates
        coord = coordinates
        print(coordinates)
        map.addAnnotation(annotation)
        performSegue(withIdentifier: "seg", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let vc = segue.destination as! SecondViewController
       vc.latitude = coord.latitude
        vc.longitude = coord.longitude
        
        
    }


}
