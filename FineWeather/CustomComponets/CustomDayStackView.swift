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
    
    
    func dayWeatherMakeStack(lat: Int, lon: Int) -> UIStackView {
        let stack1 = stackElement(timeLabel: dayInTmpLabel1, ImageView: dayInImageView1, tmpLabel: dayInTmpLabel1)
        let stack2 = stackElement(timeLabel: dayInTmpLabel2, ImageView: dayInImageView2, tmpLabel: dayInTmpLabel2)
        let stack3 = dayStackViewSetting(time: "오후 9시", image: "cloud.heavyrain.fill", tmp: "-11")
        let stack4 = dayStackViewSetting(time: "오후 9시", image: "cloud.heavyrain.fill", tmp: "-11")
        let stack5 = dayStackViewSetting(time: "오후 9시", image: "cloud.heavyrain.fill", tmp: "-11")
        let stack6 = dayStackViewSetting(time: "오후 9시", image: "cloud.heavyrain.fill", tmp: "-11")
        let stack7 = dayStackViewSetting(time: "오후 9시", image: "cloud.heavyrain.fill", tmp: "-11")
        
        var stacks = UIStackView(arrangedSubviews: [stack1, stack2, stack3, stack4, stack5, stack6, stack7])
        
        weatherAPI.dayWeatherViewSetting(baseDate: DateValue.baseDate, baseTime: DateValue.baseTime, lat: lat, lon: lon) { response in
            print("dayWeatherViewSetting: \(response)")
            self.dayInTimeLabel1.text = "오후 1시"
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
        
        timeLabel.text = "오후 4시"
        ImageView.image = UIImage(systemName: "cloud.heavyrain.fill")
        tmpLabel.text = "-19" + "˚"
        
        return stackView
    }
    
}
