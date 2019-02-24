//
//  SecondViewController.swift
//  MemorablePlaces
//
//  Created by IMCS2 on 2/23/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import MapKit

var coordinateArr = [String]()


//var coordinate : CLLocationDegrees = (0,0)


class SecondViewController: UIViewController {
    
   // var coordinate = CLLocationCoordinate2D(latitude: ,longitude: )
    var titleArr = [String?]()
    var subTitleArr = [String?]()
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var subTitleField: UITextField!
    var latitude : CLLocationDegrees!
    var longitude : CLLocationDegrees!
    
    var latitudeArr = [CLLocationDegrees?]()
    var longitudeArr = [CLLocationDegrees?]()
    
    var titletext = ""
    var subTitle = ""
    
  
    
    @IBAction func submitButton(_ sender: Any) {
//        let c = coordinate(latitude!,longitude!)
       // let coordinate = [CLLocationCoordinate2D(latitude: latitude, longitude: longitude)]
        titletext = titleField.text!
        subTitle = subTitleField.text!
        
        titleArr.append(titletext)
        subTitleArr.append(subTitle)
        latitudeArr.append(latitude)
        longitudeArr.append(longitude)
        
        UserDefaults.standard.set(titleArr, forKey: "title")
        UserDefaults.standard.set(subTitleArr,forKey:"subtitle")
       // UserDefaults.standard.set(coordinate,forKey:"coordinate")
        UserDefaults.standard.set(latitudeArr, forKey: "latitude")
        UserDefaults.standard.set(longitudeArr, forKey: "longitude")
        performSegue(withIdentifier: "segtoViewController", sender: self)
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let i = UserDefaults.standard.value(forKey: "latitude") {
        titleArr = (UserDefaults.standard.value(forKey: "title")  as? [String?])!
        subTitleArr = UserDefaults.standard.value(forKey: "subtitle") as! [String?]
        latitudeArr = UserDefaults.standard.value(forKey: "latitude") as! [CLLocationDegrees?]
        longitudeArr = UserDefaults.standard.value(forKey: "longitude") as! [CLLocationDegrees?]
        }
        // Do any additional setup after loading the view.
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
