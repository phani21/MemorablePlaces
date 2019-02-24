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
    var coordinateForSelectedMemorablePlace = CLLocationCoordinate2D(latitude: 0,longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var indexOfArray = 0
        
        //Check if UserDefaults has any values already present
        if let titleArrayFromUserDefaults = UserDefaults.standard.value(forKey: "title") as? Array<String?>{
           
                while(indexOfArray < (titleArrayFromUserDefaults.count )) {
                    let latitudeElement = (UserDefaults.standard.value(forKey: "latitude") as? [CLLocationDegrees])!
                    let longitudeElement = (UserDefaults.standard.value(forKey: "longitude") as? [CLLocationDegrees])!
                    let latitude : CLLocationDegrees = latitudeElement[indexOfArray]
                    let longitude : CLLocationDegrees = longitudeElement[indexOfArray]
                    let latDelta: CLLocationDegrees = 0.08
                    let longDelta : CLLocationDegrees = 0.08
                    let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
                    let region = MKCoordinateRegion(center: coordinates, span: span)
                    
                    map.setRegion(region, animated: true)
                    
                    
                    let titleElement = UserDefaults.standard.value(forKey:"title") as? [String]
                    let subtitleElement = UserDefaults.standard.value(forKey:"subtitle") as? [String]
                    //Adding Annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = titleElement?[indexOfArray]
                    annotation.subtitle = subtitleElement?[indexOfArray]
                    annotation.coordinate = coordinates
                    map.addAnnotation(annotation)
                    
                    //Adding long press gesture
                    
                    let uiLongPress = UILongPressGestureRecognizer(target: self, action:#selector(self.longPressAction(gustureRecognizer:)))
                    uiLongPress.minimumPressDuration = 1.0
                    map.addGestureRecognizer(uiLongPress)
                    indexOfArray+=1
                }
            
        }
        //If Userdefaults is empty then diplays Irving location mall
        else
        {
                let latitude : CLLocationDegrees = 32.840744
                let longitude : CLLocationDegrees = -96.994970
                let latDelta: CLLocationDegrees = 0.05
                let longDelta : CLLocationDegrees = 0.05
                let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
                let region = MKCoordinateRegion(center: coordinates, span: span)
                
                map.setRegion(region, animated: true)
   
                let uiLongPress = UILongPressGestureRecognizer(target: self, action:#selector(self.longPressAction(gustureRecognizer:)))
                uiLongPress.minimumPressDuration = 1.0
                map.addGestureRecognizer(uiLongPress)
        }
    }
    
    
    @objc func longPressAction(gustureRecognizer: UIGestureRecognizer){
        let touchPoint = gustureRecognizer.location(in: self.map)
        let coordinates = map.convert(touchPoint, toCoordinateFrom: self.map)
        let annotation = MKPointAnnotation()
        annotation.title = "NewLongPress"
        annotation.subtitle = "LongPressGesture"
        annotation.coordinate = coordinates
        coordinateForSelectedMemorablePlace = coordinates
        print(coordinates)
        map.addAnnotation(annotation)
        performSegue(withIdentifier: "seg", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewControllerReference = segue.destination as! SecondViewController
        secondViewControllerReference.latitude = coordinateForSelectedMemorablePlace.latitude
        secondViewControllerReference.longitude = coordinateForSelectedMemorablePlace.longitude
    }
    
    
}
