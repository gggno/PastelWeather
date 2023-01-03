import Foundation
import Alamofire

class WeatherAPI {
    
    private let url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
    
    private let serviceKey = "MXeg4k90bO3y47G4O/5DTg1S9OmMB+UUh8k+OLoX96qUae8mvDLTWXASHiIPn0HzjLqsmj7jr7n/lUL00YNkIQ=="
    
    // MARK: - Welcome
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
    
    
    func currentWeather(date: String, baseTime: String, completion: @escaping (WeatherResponse) -> Void) { // 현재 온도 요청
        
        let params: Parameters = [
            "serviceKey" : self.serviceKey,
            "dataType" : "JSON",
            "numOfRows" : 5,
            "pageNo" : 1,
            "base_date" : date,
            "base_time" : baseTime,
            "nx" : 56,
            "ny" : 125
        ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseDecodable(of: WeatherResponse.self) { response in
            
            switch response.result {
            case .success(let value):
                
                completion(value)
                
            case .failure(let error):
                print("현재 온도 통신 실패 에러 메시지: \(error)")
            }
        }
    }
    
    func maxMinWeather(date: String, baseTime: String) { // 최저, 최고 온도 요청
        
    }
    
    
}
