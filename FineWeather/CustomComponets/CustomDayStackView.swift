//
//  CustomDayStackView.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/23.
//

import Foundation
import UIKit
import SnapKit
import CoreLocation

class CustomDayStackView: UIStackView {
    
    // MARK: - dayWeatherView 데이터 로직
    let weatherAPI = WeatherAPI()
    
    func dayWeatherMakeStack(lat: Int, lon: Int) -> UIStackView {
        let stack1 = stackElement(timeLabel: dayInTimeLabel1, ImageView: dayInImageView1, tmpLabel: dayInTmpLabel1)
        let stack2 = stackElement(timeLabel: dayInTimeLabel2, ImageView: dayInImageView2, tmpLabel: dayInTmpLabel2)
        let stack3 = stackElement(timeLabel: dayInTimeLabel3, ImageView: dayInImageView3, tmpLabel: dayInTmpLabel3)
        let stack4 = stackElement(timeLabel: dayInTimeLabel4, ImageView: dayInImageView4, tmpLabel: dayInTmpLabel4)
        let stack5 = stackElement(timeLabel: dayInTimeLabel5, ImageView: dayInImageView5, tmpLabel: dayInTmpLabel5)
        let stack6 = stackElement(timeLabel: dayInTimeLabel6, ImageView: dayInImageView6, tmpLabel: dayInTmpLabel6)
        let stack7 = dayStackViewSetting(time: "오후 9시", image: "cloud.heavyrain.fill", tmp: "-11")
        
        var stacks = UIStackView(arrangedSubviews: [stack1, stack2, stack3, stack4, stack5, stack6, stack7])
        
        weatherAPI.dayWeatherViewSetting(baseDate: DateValue.baseDate, baseTime: DateValue.baseTime, lat: lat, lon: lon) { response in
//            print("dayWeatherViewSetting: \(response)")
            print("세팅 날짜: \(DateValue.baseDate), 세팅 시간: \(DateValue.baseTime)")
            var index = 0
            for i in 0..<24 {
                if response.response?.body?.items.item[index].category == "TMP" {
                    print("i = response.response?.body?.items.item[\(index)](\(i+1))\nvalue = \(response.response?.body?.items.item[index])\n")
                    index += 12
                } else {
                    index += 1
                    print("i = response.response?.body?.items.item[\(index)]\nvalue = \(response.response?.body?.items.item[index])\n")
                    index += 12
                }
            }
            self.dayInTimeLabel1.text = "오후 1시"
            self.dayInImageView1.image = UIImage(systemName: "cloud.heavyrain.fill")
            self.dayInTmpLabel1.text = "-0"
        }
        return stacks
    }
    
    func dayStackViewSetting(time: String, image: String, tmp: String) -> UIStackView {
         
        let dayInTimeLabel: UILabel = {
            let label = UILabel()
            
            return label
        }()
        
        let dayInImageView: UIImageView = {
            let imageView = UIImageView()
            
            return imageView
        }()
        
        let dayInTmpLabel: UILabel = {
            let label = UILabel()
            
            return label
        }()
        
        let stackView = UIStackView(arrangedSubviews: [dayInTimeLabel, dayInImageView, dayInTmpLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        dayInTimeLabel.text = time
        dayInImageView.image = UIImage(systemName: image)
        dayInTmpLabel.text = tmp + "˚"
        
        return stackView
    }
    
    // 라벨, 이미지를 위에 하나하나 할당한 다음 이 함수를 이용하여 스택뷰를 만든다.
    func stackElement(timeLabel: UILabel, ImageView: UIImageView, tmpLabel: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, ImageView, tmpLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        timeLabel.text = "정보 없음"
        ImageView.image = UIImage(systemName: "cloud.heavyrain.fill")
        tmpLabel.text = "정보 없음"
        
        return stackView
    }
    
    // MARK: - 스택뷰 요소 할당(24개)
    let dayInTimeLabel1: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInImageView1: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel1: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInTimeLabel2: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInImageView2: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel2: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInTimeLabel3: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInImageView3: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel3: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInTimeLabel4: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInImageView4: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel4: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInTimeLabel5: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInImageView5: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel5: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInTimeLabel6: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInImageView6: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel6: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
}
