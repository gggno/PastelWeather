//
//  FineDustDatas.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/04.
//

import Foundation

class FineDustDatas {
    static let shared = FineDustDatas()
    
    var pm10Value: String?
    var pm10Grade: String?
    var pm25Value: String?
    var pm25Grade: String?
    
    private init() { }
}
