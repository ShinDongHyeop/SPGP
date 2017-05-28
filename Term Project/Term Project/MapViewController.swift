//
//  MapViewController.swift
//  Term Project
//
//  Created by KPUGAME on 2017. 5. 21..
//  Copyright © 2017년 DONGHYEOP SHIN. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    var posts = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 37.319672, longitude: 126.822556)
        
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        loadInitialData()
        mapView.addAnnotations(festivals)
        // Do any additional setup after loading the view.
    }
    
    
    let regionRadius: CLLocationDistance = 5000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var festivals = [Festival]()
    
    func loadInitialData() {
        for post in posts {
            let FASTVL_CONT = (post as AnyObject).value(forKey: "FASTVL_CONT") as! NSString as String
            let HMPG_ADDR = (post as AnyObject).value(forKey: "FASTVL_BEGIN_DE") as! NSString as String
            let XPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LOGT") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "REFINE_WGS84_LAT") as! NSString as String
            let lat = (YPos as NSString).doubleValue
            let lon = (XPos as NSString).doubleValue
            let festival = Festival(title: FASTVL_CONT, locationName: HMPG_ADDR, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            
            festivals.append(festival)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, celloutAccessoryControlTapped control: UIControl)
    {
        let location = view.annotation as! Festival
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Festival {
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            // 2. 코드는 새로 생성하기 전에 재사용 가능한 주석 뷰를 사용할 수 있는지 먼저 확인
            if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeueView.annotation = annotation
                view = dequeueView
            }
            else {
                // 3. 주석보기를 대기열에서 제외 할 수 없는 경우 일반 바닐라 MKAnnotationView 클래스를 사용한다.
                //    Artwork 클래스의 title 및 subtitle 속성을 사용하여 설명 선에 표시 할 내용을 결정한다.ㅌ
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            view.pinTintColor = MKPinAnnotationView.greenPinColor()
            return view
        }
        return nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
