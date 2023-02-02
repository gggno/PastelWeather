//
//  FineDustResponse.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/01.
//

import Foundation
import Alamofire

class FineDustAPI {
    // tm 좌표 찾기
    private let findTmUrl = "http://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getTMStdrCrdnt"
    private let findTmServiceKey = "MXeg4k90bO3y47G4O/5DTg1S9OmMB+UUh8k+OLoX96qUae8mvDLTWXASHiIPn0HzjLqsmj7jr7n/lUL00YNkIQ=="
    
    // MARK: - TMFine
    struct FindTmResponse: Codable {
        let response: Response
    }
    // MARK: - Response
    struct Response: Codable {
        let body: Body
        let header: Header
    }
    // MARK: - Body
    struct Body: Codable {
        let totalCount: Int
        let items: [Item]
        let pageNo, numOfRows: Int
    }
    // MARK: - Item
    struct Item: Codable {
        let sggName, umdName, tmX, tmY: String
        let sidoName: String
    }
    // MARK: - Header
    struct Header: Codable {
        let resultMsg, resultCode: String
    }
    
    func currentTm(completion: @escaping (FindTmResponse) -> Void) {
        let params: Parameters = [
            "serviceKey" : self.findTmServiceKey,
            "returnType" : "JSON",
            "numOfRows" : 36,
            "pageNo" : 1,
            "umdName" : "혜화동"
        ]
        
        AF.request(findTmUrl, method: .get, parameters: params, encoding: URLEncoding.default).responseDecodable(of: FindTmResponse.self) { response in
            
            switch response.result {
            case .success(let value):
                print("TM 좌표 통신 선공")
                completion(value)
                
            case .failure(let error):
                print("TM 좌표 통신 실패 에러 메시지: \(error)")
            }
        }
        
    }
    
    
    
    
}
