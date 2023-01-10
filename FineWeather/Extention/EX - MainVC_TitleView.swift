//
//  EX - MainVC_TitleView.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/23.
//

import Foundation
import UIKit

// titleView 구성
extension MainViewController {
    
    func titleViewSetting() -> UIView {
        
        //MARK: - UI 로직
        let titleInImageView: UIImageView = {
            let imageView = UIImageView()
            
//            imageView.image = UIImage(systemName: presentImage)
            imageView.backgroundColor = .white
            
            return imageView
        }()
        
        let titleInWeatherTextLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = .clear
            label.text = "_ _"
            
            return label
        }()
        
        let titleInTempNum: UILabel = {
            let label = UILabel()
            label.backgroundColor = .magenta
            label.textAlignment = .center
            label.font = label.font.withSize(40)
            label.text = "_ _"
            // label.text는 통신 후에 결정
            
            return label
        }()
        
        let titleInmaxTempStackView = CustomTempStackView().tempSetting(tempName: "최고", tempNameColor: .red, lat: self.lat, lon: self.lon)
        let titleInminTempStackView = CustomTempStackView().tempSetting(tempName: "최저", tempNameColor: .blue, lat: self.lat, lon: self.lon)
        
        let titleInTempStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleInmaxTempStackView, titleInminTempStackView])
            
            stackView.axis = .vertical
            stackView.spacing = 20
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            
            return stackView
        }()
        
        let titleInTopTempStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleInTempNum, titleInTempStackView])
            
            stackView.axis = .horizontal
            stackView.spacing = 20
            stackView.alignment = .center
            stackView.distribution = .equalSpacing
            
            return stackView
        }()
        
        let titleInBottomStackView = CustomTempStackView().tempSetting(tempName: "체감온도", tempNameColor: .white, lat: self.lat, lon: self.lon)
        
        let titleView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .systemCyan
            view.addSubview(titleInImageView)
            view.addSubview(titleInWeatherTextLabel)
            view.addSubview(titleInTopTempStackView)
            view.addSubview(titleInBottomStackView)
            
            return view
        }()
        
        titleInImageView.snp.makeConstraints { make in
            make.size.equalTo(90)
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleInWeatherTextLabel.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(30)
            make.leading.equalTo(titleInImageView.snp.leading)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        titleInTopTempStackView.snp.makeConstraints { make in
            make.top.equalTo(titleInImageView.snp.top)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        titleInBottomStackView.snp.makeConstraints { make in
            make.top.equalTo(titleInTopTempStackView.snp.bottom).offset(30)
            make.centerX.equalTo(titleInTopTempStackView.snp.centerX)
        }
        
        //MARK: - 데이터 로직
        let weatherAPI = WeatherAPI()
        
        // 현재 온도 구현 로직
        weatherAPI.currentWeather(baseDate: DateValue.baseDate, baseTime: DateValue.baseTime, lat: self.lat, lon: self.lon) { response in
            var index = 0
            let difference = abs(Int(DateValue.currentTime)! - Int(DateValue.baseTime)!)
            
            if difference == 2300 || difference == 100 {
                index = 0
            } else if difference == 2200 || difference == 200 {
                index = 12
            } else if difference == 2100 || difference == 300 {
                index = 24
            }
            
            print(response.response?.body?.items.item[index])
            if let currentTmp = response.response?.body?.items.item[index].fcstValue {
                // 현재온도
                titleInTempNum.text = currentTmp + "˚"
            } else { titleInTempNum.text = "_ _" }
        }
        
        weatherAPI.lookWeather(baseDate: DateValue.baseDate, baseTime: DateValue.baseTime, lat: self.lat, lon: self.lon) { response in
            var index = 0
            let difference = abs(Int(DateValue.currentTime)! - Int(DateValue.baseTime)!)
            
            if difference == 2300 || difference == 100 {
                index = 5
            } else if difference == 2200 || difference == 200 {
                index = 17
            } else if difference == 2100 || difference == 300 {
                index = 29
            }
//            하늘상태(SKY) 코드 : 맑음(1), 구름많음(3), 흐림(4)
//            강수형태(PTY) 코드 : (초단기) 없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7)
//                             (단기) 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)

            guard let sky = response.response?.body?.items.item[index].fcstValue else {return} // 하늘상태
            guard let pty = response.response?.body?.items.item[index+1].fcstValue else {return} // 강수형태
            
            if sky == "1" { // 맑음
                titleInImageView.image = UIImage(systemName: "sun.max.fill")
                titleInWeatherTextLabel.text = "맑아요"
            } else if sky == "3" { // 구름 많음
                titleInImageView.image = UIImage(systemName: "smoke.fill")
                titleInWeatherTextLabel.text = "구름 많아요"
            } else if sky == "4" && pty == "0" { // 흐림
                titleInImageView.image = UIImage(systemName: "cloud.fill")
                titleInWeatherTextLabel.text = "흐려요"
                
            } else {
                if pty == "1" { // 비
                    titleInImageView.image = UIImage(systemName: "cloud.rain.fill")
                    titleInWeatherTextLabel.text = "비와요"
                } else if pty == "2" { // 비/눈
                    titleInImageView.image = UIImage(systemName: "cloud.hail.fill")
                    titleInWeatherTextLabel.text = "비랑 눈이와요"
                } else if pty == "3" { // 눈
                    titleInImageView.image = UIImage(systemName: "snowflake")
                    titleInWeatherTextLabel.text = "눈와요"
                } else if pty == "4" { // 소나기
                    titleInImageView.image = UIImage(systemName: "cloud.rain.fill")
                    titleInWeatherTextLabel.text = "소나기와요"
                }
            }
            
        }
        
        return titleView
    }
}
