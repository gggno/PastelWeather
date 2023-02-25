//
//  AddedCityDatas.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/20.
//

import Foundation
import UIKit
import RealmSwift

class AddedCityDatas {
    static let shared = AddedCityDatas()
    
    var vcDatas: [UIViewController] = []
    
    private init() { }
}
