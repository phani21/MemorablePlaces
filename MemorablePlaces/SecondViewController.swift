//
//  SecondViewController.swift
//  MemorablePlaces
//
//  Created by IMCS2 on 2/23/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import MapKit


class SecondViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var subTitleField: UITextField!
    
    
    var titleArray = [String?]()
    var subtitleArray = [String?]()
    var latitudeArray = [CLLocationDegrees?]()
    var longitudeArray = [CLLocationDegrees?]()
    
    var latitude : CLLocationDegrees!
    var longitude : CLLocationDegrees!
    var coordinatesArray = [String]()
    
    var titletext = ""
    var subtitleText = ""
    
    @IBAction func submitButton(_ sender: Any) {
        titletext = titleField.text!
        subtitleText = subTitleField.text!
        
        titleArray.append(titletext)
        subtitleArray.append(subtitleText)
        latitudeArray.append(latitude)
        longitudeArray.append(longitude)
        
        UserDefaults.standard.set(titleArray, forKey: "title")
        UserDefaults.standard.set(subtitleArray,forKey:"subtitle")
        UserDefaults.standard.set(latitudeArray, forKey: "latitude")
        UserDefaults.standard.set(longitudeArray, forKey: "longitude")
        performSegue(withIdentifier: "segtoViewController", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "latitude") != nil {
            titleArray = (UserDefaults.standard.value(forKey: "title")  as? [String?])!
            subtitleArray = UserDefaults.standard.value(forKey: "subtitle") as! [String?]
            latitudeArray = UserDefaults.standard.value(forKey: "latitude") as! [CLLocationDegrees?]
            longitudeArray = UserDefaults.standard.value(forKey: "longitude") as! [CLLocationDegrees?]
        }
        // Do any additional setup after loading the view.
    }
}
