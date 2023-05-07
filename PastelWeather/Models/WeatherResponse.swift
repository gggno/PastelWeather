//
//  WeatherResponse.swift
//  FineWeather
//
//  Created by 정근호 on 2023/03/01.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Decodable {
    var response: Response?
}

// MARK: - Response
struct Response: Decodable {
    var header: Header
    var body: Body?
}

// MARK: - Body
struct Body: Decodable {
    var dataType: String
    var items: Items
    var pageNo: Int
    var numOfRows: Int
    var totalCount: Int
}

// MARK: - Items
struct Items: Decodable {
    var item: [Item]
}

// MARK: - Item
struct Item: Decodable {
    var baseDate: String
    var baseTime: String
    var category: String
    var fcstDate: String
    var fcstTime: String
    var fcstValue: String
    var nx: Int
    var ny: Int
}

// MARK: - Header
struct Header: Decodable {
    var resultCode: String
    var resultMsg: String
}
