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
    
    func tempSetting(tempName: String, tempNameColor: UIColor) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [tempNameLabel, tempLabel])
        let weatherAPI = WeatherAPI()
        
        if tempName == "최고" {
            print("최고 온도")
            weatherAPI.maxWeather(baseDate: DateValue.baseDate, currentTime: DateValue.currentTime) { response in
                print("max:\(response.response?.body?.items.item[0])")
                if let maxTmp = response.response?.body?.items.item[0].fcstValue {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = maxTmp + "˚"
                } else {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = "_ _"
                }
            }
            
        } else if tempName == "최저" {
            print("최저 온도")
            weatherAPI.minWeather(baseDate: DateValue.baseDate, currentTime: DateValue.currentTime) { response in
                if let minTmp = response.response?.body?.items.item[0].fcstValue {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = minTmp + "˚"
                } else {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = "_ _"
                }
            }
            
        } else if tempName == "체감온도" {
            print("체감 온도")
            
            weatherAPI.currentWeather(baseDate: DateValue.baseDate, baseTime: DateValue.baseTime) { response in
                var index = 0
                let difference = abs(Int(DateValue.currentTime)! - Int(DateValue.baseTime)!)
                
                if difference == 2300 || difference == 100 {
                    index = 0
                } else if difference == 2200 || difference == 200 {
                    index = 12
                } else if difference == 2100 || difference == 300 {
                    index = 24
                }
                
                print("feelTmp: \(response.response?.body?.items.item[index])")
                print("feelWSD: \(response.response?.body?.items.item[index+4])")
                
                guard let tmp = response.response?.body?.items.item[index].fcstValue else { return }
                guard let wsd = response.response?.body?.items.item[index+4].fcstValue else { return }
                
                let t = Double(tmp)! // 온도
                let v = pow(Double(wsd)!, 0.16) // 풍속
                
                let tmpCal: Double = round(13.12 + 0.6215 * t - 11.37 * v + 0.3965 * v * t)
                let feelTmpSTr: String? = String(Int(tmpCal))
                
                if let feelTmp = feelTmpSTr {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = feelTmp + "˚"
                    
                } else {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = "_ _"
                }
            }
        }
        
        tempNameLabel.textColor = tempNameColor
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }
    
}
