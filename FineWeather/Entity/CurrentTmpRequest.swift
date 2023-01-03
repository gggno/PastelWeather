//
//  CurrentTmpRequest.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/27.
//

import Foundation

struct CurrentTmpRequest: Encodable {
    var serviceKey: String
    var dataType: String
    var numOfRows: Int
    var pageNo: Int
    var baseDate: String
    var baseTime: String
    var nx: Int
    var ny: Int
    
    enum CodingKeys: String, CodingKey {
        case serviceKey
        case dataType
        case numOfRows
        case pageNo
        case baseDate = "base_date"
        case baseTime = "base_time"
        case nx
        case ny
    }
    
    init(serviceKey: String, numOfRows: Int, pageNo: Int, dataType: String, baseDate: String, baseTime: String, nx: Int, ny: Int) {
        self.serviceKey = serviceKey
        self.numOfRows = numOfRows
        self.pageNo = pageNo
        self.dataType = dataType
        self.baseDate = baseDate
        self.baseTime = baseTime
        self.nx = nx
        self.ny = ny
    }
    
}
