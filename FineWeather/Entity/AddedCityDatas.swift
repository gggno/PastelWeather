//
//  AddedCityDatas.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/20.
//

import Foundation

class AddedCityDatas {
    static let shared = AddedCityDatas()
    
    var cityDatas: [String] = []
    
    private init() { }
}
