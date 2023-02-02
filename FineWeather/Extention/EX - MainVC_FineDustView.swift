//
//  EX - MainVC_FineDustView.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/01.
//

import Foundation
import Alamofire

extension MainViewController {
    
    func getLocationInNaver(url: String, lat: Double, lon: Double, completion: @escaping (String) -> Void) {
        let clientIdHeader = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: "8rehiz90fq")
        let clientSecretKeyHeader = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: "QNY4SodLgUxoFRfgiXMQnpz6wLTW5BwcVvZ18gQA")
        let headers = HTTPHeaders([clientIdHeader, clientSecretKeyHeader])
        print("네이버: \(self.naverLon),\(self.naverLat)")
        let params: Parameters = [
            "coords" : "\(self.naverLon),\(self.naverLat)",
            "output" : "json"
        ]
        
        AF.request(url, method: .get, parameters: params, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                print("네이버 통신 성공")
                print("네이버 value: \(value)")
                
                
                
            case .failure(let error):
                print("네이버 통신 실패 에러 메시지: \(error)")
            }
        }
        
    }
}
