//
//  DateValue.swift
//  FineWeather
//
//  Created by 정근호 on 2023/01/06.
//

import Foundation

class DateValue {
    
    static let baseDate: String = {
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH00"
        
        // 현재시간이 0000~0200이면 전날 날짜의 2300시로 조회
        if formatter.string(from: time) == "0000" || formatter.string(from: time) == "0100" || formatter.string(from: time) == "0200" {
            let date = Date(timeIntervalSinceNow: -86400)
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYYMMdd"
            
            return formatter.string(from: date)
        }
        // 현재시간이 0300~2300이면 오늘 날짜의 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300시로 조회
        else {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYYMMdd"
            
            return formatter.string(from: date)
        }
    }()
    
    static let maxBaseDate: String = {
        if Int(currentTime)! <= 1100 { // 11시 이전이면 어제 날짜로 변환
            let date = Date(timeIntervalSinceNow: -86400)
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYYMMdd"
            
            return formatter.string(from: date)
        } else { // 11시 이후면 오늘 날짜
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYYMMdd"
            
            return formatter.string(from: date)
        }
    }()
    
    static let baseTime: String = {
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH00"
        
        switch Int(formatter.string(from: time))! {
        case 0000...0259:
            print("0000...0259")
            print("어제의 2300") // 어제 2300
            return "2300"
            
        case 0300...0559:
            print("0200...0559")
            print("0200")
            return "0200"
            
        case 0600...0859:
            print("0500...0859")
            print("0500")
            return "0500"
            
        case 0900...1159:
            print("0800...1159")
            print("0800")
            return "0800"
            
        case 1200...1459:
            print("1100...1459")
            print("1100")
            return "1100"
            
        case 1500...1759:
            print("1400...1759")
            print("1400")
            return "1400"
            
        case 1800...2059:
            print("1700...2059")
            print("1700")
            return "1700"
            
        case 2100...2359:
            print("2000...2359")
            print("2000")
            return "2000"
            
        default:
            print("default")
            return "0000"
        }
    }()
    
    // bsseTime과 차이를 비교하여 인덱스 값을 구하기 위한 용도
    static let currentTime: String = {
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH00"
        
        return formatter.string(from: time)
    }()
    
    // 오전, 오후를 구분하는 한시간 뒤 시간
    static func currentTimeOfAmPm(count: Double) -> String {
        let time = Date(timeIntervalSinceNow: 3600*count)
        let formatter = DateFormatter()
        formatter.dateFormat = "a h시"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: time)
    }
    
}
