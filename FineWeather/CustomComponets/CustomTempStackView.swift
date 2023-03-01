//
//  CustomTempView.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/22.
//

import Foundation
import UIKit

class CustomTempStackView: UIStackView {
    
    let tempNameLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .orange
        
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "_ _"
        
        return label
    }()
    
    func tempSetting(tempName: String, tempNameColor: UIColor, lat: Int, lon: Int) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [tempNameLabel, tempLabel])
        let weatherAPI = WeatherAPI()
        
        if tempName == "최고" {
            print("최고 온도")
            weatherAPI.maxWeather(baseDate: DateValue.maxBaseDate, currentTime: DateValue.currentTime, lat: lat, lon: lon) { response in
                
                if response.response?.body?.items.item[0].baseDate == response.response?.body?.items.item[0].fcstDate {
                    print("날짜 같음max: \(String(describing: response.response?.body?.items.item[0]))")
                    if let maxTmp = response.response?.body?.items.item[0].fcstValue {
                        self.tempNameLabel.text = tempName + ":"
                        self.tempLabel.text = maxTmp + "˚"
                        self.tempNameLabel.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
                        self.tempLabel.font = self.tempLabel.font.withSize(15)
                        self.tempLabel.textColor = .red
                    } else {
                        self.tempNameLabel.text = tempName + ":"
                        self.tempLabel.text = "_ _"
                        self.tempNameLabel.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
                        self.tempLabel.font = self.tempLabel.font.withSize(15)
                        self.tempLabel.textColor = .red
                    }
                } else {
                    print("날짜 다름max: \(String(describing: response.response?.body?.items.item[1]))")
                    if let maxTmp = response.response?.body?.items.item[1].fcstValue {
                        self.tempNameLabel.text = tempName + ":"
                        self.tempLabel.text = maxTmp + "˚"
                        self.tempNameLabel.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
                        self.tempLabel.font = self.tempLabel.font.withSize(15)
                        self.tempLabel.textColor = .red
                    } else {
                        self.tempNameLabel.text = tempName + ":"
                        self.tempLabel.text = "_ _"
                        self.tempNameLabel.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
                        self.tempLabel.font = self.tempLabel.font.withSize(15)
                        self.tempLabel.textColor = .red
                    }
                }
            }
            
        } else if tempName == "최저" {
            print("최저 온도")
            weatherAPI.minWeather(baseDate: DateValue.minBaseDate, currentTime: DateValue.currentTime, lat: lat, lon: lon) { response in
                if let minTmp = response.response?.body?.items.item[0].fcstValue {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = minTmp + "˚"
                    self.tempNameLabel.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
                    self.tempLabel.font = self.tempLabel.font.withSize(15)
                    self.tempLabel.textColor = .blue
                } else { // 조회 실패
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = "_ _"
                    self.tempNameLabel.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
                    self.tempLabel.font = self.tempLabel.font.withSize(15)
                    self.tempLabel.textColor = .blue
                }
            }
            
        } else if tempName == "체감온도" {
            print("체감 온도")
            
            weatherAPI.currentWeather(baseDate: DateValue.baseDate, baseTime: DateValue.baseTime, lat: lat, lon: lon) { response in
                var index = 0
                let difference = abs(Int(DateValue.currentTime)! - Int(DateValue.baseTime)!)
                
                if difference == 2300 || difference == 100 {
                    index = 0
                } else if difference == 2200 || difference == 200 {
                    index = 12
                } else if difference == 2100 || difference == 300 {
                    index = 24
                }
                
                print("feelTmp: \(String(describing: response.response?.body?.items.item[index]))")
                print("feelWSD: \(String(describing: response.response?.body?.items.item[index+4]))")
                
                guard let tmp = response.response?.body?.items.item[index].fcstValue else { return }
                guard let wsd = response.response?.body?.items.item[index+4].fcstValue else { return }
                
                let t = Double(tmp)! // 온도
                let v = pow(Double(wsd)!, 0.16) // 풍속
                
                let tmpCal: Double = round(13.12 + 0.6215 * t - 11.37 * v + 0.3965 * v * t)
                let feelTmpStr: String? = String(Int(tmpCal))
                
                if let feelTmp = feelTmpStr {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempNameLabel.font = UIFont(name: "GmarketSansTTFMedium", size: 17)
                    self.tempLabel.text = feelTmp + "˚"
                    
                    self.tempLabel.textColor = .black
                    
                } else {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempNameLabel.font = UIFont(name: "GmarketSansTTFMedium", size: 17)
                    
                    self.tempLabel.text = "_ _"
                    self.tempLabel.textColor = .black
                }
            }
        }
        
        tempNameLabel.textColor = tempNameColor
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        
        return stackView
    }
    
}
