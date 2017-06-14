//
//  Festival.swift
//  Term Project
//
//  Created by KPUGAME on 2017. 5. 28..
//  Copyright © 2017년 DONGHYEOP SHIN. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

class Event: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    // subtitle은 locationName을 반환하는 computed property
    var subtitle: String? {
        return locationName
    }
    
    // 클래스에 추가하는 helper 메소드
    // MKPlacemark로 부터 MKKapItem을 생성
    // info button을 누르면 MKMapItem을 오픈하게 됨
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey) : subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
}
