import Foundation
import Alamofire

class WeatherAPI: NSObject {
    
    private let url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"
    private let serviceKey = "MXeg4k90bO3y47G4O/5DTg1S9OmMB+UUh8k+OLoX96qUae8mvDLTWXASHiIPn0HzjLqsmj7jr7n/lUL00YNkIQ=="
    
    // MARK: - titleView 세팅
    func currentWeather(baseDate: String, baseTime: String, lat: Int, lon: Int, completion: @escaping (WeatherResponse) -> Void) { // 현재 온도 요청
        let params: Parameters = [
            "serviceKey" : self.serviceKey,
            "dataType" : "JSON",
            "numOfRows" : 36,
            "pageNo" : 1,
            "base_date" : baseDate,
            "base_time" : baseTime,
            "nx" : lat,
            "ny" : lon
        ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseDecodable(of: WeatherResponse.self) { response in
            
            switch response.result {
            case .success(let value):
                print("현재 온도 통신 성공")
                completion(value)
                
            case .failure(let error):
                print("현재 온도 통신 실패 에러 메시지: \(error)")
            }
        }
    }
    
    func minWeather(baseDate: String, currentTime: String, lat: Int, lon: Int, completion: @escaping (WeatherResponse) -> Void) { // 최저 온도 요청
        // 0000~0200이면 전날 날짜의 2000로 조회
        // 0300~2300이면 오늘 날짜의 0200로 조회(0200으로 조회해야 tmn이 나옴)
        
        var settingTime = "0200"
        var settingNumOfRows = 12
        var settingPageNo = 5
        
        if Int(currentTime)! <= 0200 { 
            settingTime = "2000"
            settingNumOfRows = 12
            settingPageNo = 11
            
        } else {
            settingTime = "0200"
            settingNumOfRows = 12
            settingPageNo = 5
        }
        
        let params: Parameters = [
            "serviceKey" : self.serviceKey,
            "dataType" : "JSON",
            "numOfRows" : settingNumOfRows,
            "pageNo" : settingPageNo,
            "base_date" : baseDate,
            "base_time" : settingTime,
            "nx" : lat,
            "ny" : lon
        ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseDecodable(of: WeatherResponse.self) { response in
            
            switch response.result {
            case .success(let value):
                print("최저 온도 통신 성공")
                completion(value)
                
            case.failure(let error):
                print("최저 온도 통신 실패 에러 메시지: \(error)")
            }
        }
    }
    
    func maxWeather(baseDate: String, currentTime: String, lat: Int, lon: Int, completion: @escaping (WeatherResponse) -> Void) { // 최고 온도 요청
        // 0000~1159이면 전날 날짜의 2000로 조회
        // 1200~2359이면 오늘 날짜의 1100로 조회
        var settingTime = "1100"
        var settingNumOfRows = 12
        var settingPageNo = 5
        
        if Int(currentTime)! <= 1100 { // 어제 날짜로 조회
            settingTime = "2000"
            settingNumOfRows = 12
            settingPageNo = 20
            
        } else {                        // 오늘 날짜로 조회
            settingTime = "1100"
            settingNumOfRows = 12
            settingPageNo = 5
        }

        let params: Parameters = [
            "serviceKey" : self.serviceKey,
            "dataType" : "JSON",
            "numOfRows" : settingNumOfRows,
            "pageNo" : settingPageNo,
            "base_date" : baseDate,
            "base_time" : settingTime,
            "nx" : lat,
            "ny" : lon
        ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let value):
                print("최고 온도 통신 성공")
                completion(value)
                
            case.failure(let error):
                print("최고 온도 통신 실패 에러 메시지: \(error)")
            }
        }
    }
    
    func lookWeather(baseDate: String, baseTime: String, lat: Int, lon: Int, completion: @escaping (WeatherResponse) -> Void) { // 날씨상태 텍스트(ex 맑음) 통신 요청
        let params: Parameters = [
            "serviceKey" : self.serviceKey,
            "dataType" : "JSON",
            "numOfRows" : 36,
            "pageNo" : 1,
            "base_date" : baseDate,
            "base_time" : baseTime,
            "nx" : lat,
            "ny" : lon
        ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let value):
                print("날씨 상태 통신 성공")
                completion(value)
                
            case .failure(let error):
                print("날씨 상태 통신 실패 에러 메시지: \(error)")
            }
        }
    }
    
    // MARK: - dayWeatherView 세팅
    func dayWeatherViewSetting(baseDate: String, baseTime: String, lat: Int, lon: Int, completion: @escaping (WeatherResponse) -> Void) { // 24시 날씨 통신 요청
        let params: Parameters = [
            "serviceKey" : self.serviceKey,
            "dataType" : "JSON",
            "numOfRows" : 370,
            "pageNo" : 1,
            "base_date" : baseDate,
            "base_time" : baseTime,
            "nx" : lat,
            "ny" : lon
        ]
        
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseDecodable(of: WeatherResponse.self) { response in
            
            switch response.result {
            case .success(let value):
                print("24시 예보 통신 성공")
                completion(value)
                
            case .failure(let error):
                print("24시 예보 통신 실패 에러 메시지: \(error)")
            }
        }
    }
}
