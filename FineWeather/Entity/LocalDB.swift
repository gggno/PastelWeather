//
//  LocalDB.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/23.
//

import Foundation
import RealmSwift

class LocalDB: Object {
    @objc dynamic var vcData: String = ""
    @objc dynamic var cityName: String = ""
}
