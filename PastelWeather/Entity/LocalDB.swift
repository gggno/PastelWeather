//
//  LocalDB.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/23.
//

import Foundation
import RealmSwift

class LocalDB: Object {
    @objc dynamic var lat: Int = 0
    @objc dynamic var lon: Int = 0

    @objc dynamic var doubleLat: Double = 0.0
    @objc dynamic var doubleLon: Double = 0.0

    @objc dynamic var cityName: String = ""
    
    @objc dynamic var currentVCConfirm: Bool = false
}
