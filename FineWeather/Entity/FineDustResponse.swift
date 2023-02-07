//
//  FineDustResponse.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/01.
//

import Foundation
import Alamofire
import SwiftyJSON

class FineDustAPI: NSObject {
    
    private let kakaoUrl = "https://dapi.kakao.com/v2/local/geo/transcoord.json"
    private let nearCenterUrl = "http://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getNearbyMsrstnList"
    private let fineDustInfoUrl = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"
    
    // 카카오
    func getTMInKakao(lat: Double, lon: Double, conpletion: @escaping (UserLocation) -> Void) {
        var userLocation = UserLocation()
        
        let headers: HTTPHeaders = ["Authorization" : "KakaoAK 6844afd8070e01407f249591505ec0e4"]
        let params: Parameters = [
            "x" : lon,
            "y" : lat,
            "output_coord" : "TM"
        ]
        
        AF.request(kakaoUrl, method: .get, parameters: params, encoding: URLEncoding.queryString, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("카카오 통신 성공")
                
                let json = JSON(value)
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
    func getNearCenter(tmX: Double, tmY: Double, completion: @escaping (String) -> Void) {

        let params: Parameters = [
                        "serviceKey" : "MXeg4k90bO3y47G4O/5DTg1S9OmMB+UUh8k+OLoX96qUae8mvDLTWXASHiIPn0HzjLqsmj7jr7n/lUL00YNkIQ==",
                        "tmX" : tmX,
                        "tmY" : tmY,
                        "returnType" : "json"
                    ]
        
        AF.request(nearCenterUrl, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { response in
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
    
    // 측정소에서 얻은 정보 활용
    func getFindDust(stationName: String, completion: @escaping (String, String, String, String, String, String) -> Void) {
        let params: Parameters = [
                    "serviceKey" : "MXeg4k90bO3y47G4O/5DTg1S9OmMB+UUh8k+OLoX96qUae8mvDLTWXASHiIPn0HzjLqsmj7jr7n/lUL00YNkIQ==",
                    "stationName" : stationName,
                    "dataTerm" : "DAILY",
                    "returnType" : "json",
                    "ver" : "1.0"
                 ]
        
        AF.request(fineDustInfoUrl, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("측정소 정보 얻기 통신 성공")
                let json = JSON(value)
                
                let pm10Value = json["response"]["body"]["items"][0]["pm10Value"].string ?? "0" // 미세먼지 농도
                let pm10Grade = json["response"]["body"]["items"][0]["pm10Grade"].string ?? "0" // 미세먼지 단계
                let pm25Value = json["response"]["body"]["items"][0]["pm25Value"].string ?? "0" // 초미세먼지 농도
                let pm25Grade = json["response"]["body"]["items"][0]["pm25Grade"].string ?? "0" // 초미세먼지 단계
                let o3Value = json["response"]["body"]["items"][0]["o3Value"].string ?? "0" // 오존 농도
                let o3Grade = json["response"]["body"]["items"][0]["o3Grade"].string ?? "0" // 오존 농도
                
                FineDustDatas.shared.pm10Value = pm10Value
                FineDustDatas.shared.pm10Grade = pm10Grade
                FineDustDatas.shared.pm25Value = pm25Value
                FineDustDatas.shared.pm25Grade = pm25Grade
                FineDustDatas.shared.o3Value = o3Value
                FineDustDatas.shared.o3Grade = o3Grade
                
                completion(pm10Value, pm10Grade, pm25Value, pm25Grade, o3Value, o3Grade)
            case .failure(let error):
                print("측정소 정보 얻기 통신 실패 에러 메시지: \(error)")
            }
        }
    }
}
