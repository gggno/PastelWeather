//
//  EX - MainVC_FineDustView.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/01.
//

import Foundation
import Alamofire
import SwiftyJSON

// 네이버 -> 카카오 -> 측정소 -> 미세먼지
extension MainViewController {
    
    // 네이버
    func getLocationInNaver(url: String, lat: Double, lon: Double, completion: @escaping (String) -> Void) {
        let clientIdHeader = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: "8rehiz90fq")
        let clientSecretKeyHeader = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: "QNY4SodLgUxoFRfgiXMQnpz6wLTW5BwcVvZ18gQA")
        let headers = HTTPHeaders([clientIdHeader, clientSecretKeyHeader])
        print("네이버: \(self.doubleLat),\(self.doubleLon)")
        let params: Parameters = [
            "coords" : "\(self.doubleLon),\(self.doubleLat)",
            "output" : "json"
        ]
        
        AF.request(url, method: .get, parameters: params, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print("네이버 통신 성공")
                
                let json = JSON(value)
                let data = json["results"]
                
                let address = data[0]["region"]["area2"]["name"].string!
                print("address: \(address)")
                completion(address)
                
            case .failure(let error):
                print("네이버 통신 실패 에러 메시지: \(error)")
            }
        }
    }
    
    // 카카오
    func getTMInKakao(url: String, lat: Double, lon: Double, conpletion: @escaping (UserLocation) -> Void) {
        var userLocation = UserLocation()
        
        let headers: HTTPHeaders = ["Authorization" : "KakaoAK 6844afd8070e01407f249591505ec0e4"]
        let params: Parameters = [
            "x" : lon,
            "y" : lat,
            "output_coord" : "TM"
        ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("카카오 통신 성공")
                
                let json = JSON(value)
                print(json)
                let documents = json["documents"].arrayValue
                userLocation.longitude = documents[0]["x"].double
                userLocation.latitude = documents[0]["y"].double
                conpletion(userLocation)
                
            case .failure(let error):
                print("카카오 통신 실패 에러 메시지: \(error)")
            }
        }
    }
    
    // 근처 측정소 찾기
    func getNearCenter(url: String, tmX: Double, tmY: Double, completion: @escaping (String) -> Void) {

        let params: Parameters = [
                        "serviceKey" : "MXeg4k90bO3y47G4O/5DTg1S9OmMB+UUh8k+OLoX96qUae8mvDLTWXASHiIPn0HzjLqsmj7jr7n/lUL00YNkIQ==",
                        "tmX" : tmX,
                        "tmY" : tmY,
                        "returnType" : "json"
                    ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("근처 측정소 찾기 통신 성공")
                let json = JSON(value)
                let stationName = json["response"]["body"]["items"][0]["stationName"].string!
                print("stationName: \(stationName)")
                completion(stationName)
                
            case .failure(let error):
                print("근처 측정소 찾기 통신 실패 에러 메시지: \(error)")
            }
        }
    }
    
    func getFindDust(url: String, stationName: String, completion: @escaping (String, String, String) -> Void) {
        let params: Parameters = [
                    "serviceKey" : "MXeg4k90bO3y47G4O/5DTg1S9OmMB+UUh8k+OLoX96qUae8mvDLTWXASHiIPn0HzjLqsmj7jr7n/lUL00YNkIQ==",
                    "stationName" : stationName,
                    "dataTerm" : "DAILY",
                    "returnType" : "json"
                 ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("측정소 정보 통신 성공")
                
            case .failure(let error):
                print("측정소 정보 통신 실패 에러 메시지: \(error)")
            }
        }
        
        
    }
    
}
