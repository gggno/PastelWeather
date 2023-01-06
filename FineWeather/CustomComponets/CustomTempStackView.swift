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
                    self.tempLabel.text = "_ _" + "˚"
                }
            }
            tempNameLabel.text = tempName + ":"
            tempLabel.text = "40" + "˚"
        } else if tempName == "최저" {
            print("최저 온도")
            weatherAPI.minWeather(baseDate: DateValue.baseDate, currentTime: DateValue.currentTime) { response in
                if let minTmp = response.response?.body?.items.item[0].fcstValue {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = minTmp + "˚"
                } else {
                    self.tempNameLabel.text = tempName + ":"
                    self.tempLabel.text = "_ _" + "˚"
                }
            }
            
        } else if tempName == "체감온도" {
            print("체감 온도")
            tempNameLabel.text = tempName + ":"
            tempLabel.text = "-50" + "˚"
        }
        
        tempNameLabel.textColor = tempNameColor
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }
    
}
