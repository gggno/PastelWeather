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
        let greetingArr: [String] = ["좋은 하루 보내세요~!", "행복하고 건강하세요~!", "오늘도 파이팅~!!", "즐거운 하루 보내세요~!", "항상 응원합니다!!", "피할수 없으면 즐겨보세요!", "당신은 웃는 모습이 아릅답습니다.", "당신은 날마다 모든 면에서 점점 더 좋아지고 있습니다.", "더 멋진 하루를 보내는 당신! 아름다워요."]
        
        //MARK: - TitleView UI 로직
        let titleInImageView: UIImageView = {
            let imageView = UIImageView()
            
            return imageView
        }()
        
        let titleInWeatherTextLabel: UILabel = {
            let label = UILabel()
            
            label.textAlignment = .center
            label.textColor = .black
            label.font = UIFont(name: "GmarketSansTTFMedium", size: 18)
            label.backgroundColor = .clear
            label.text = "_ _"
            
            return label
        }()
        
        let titleInTempNum: UILabel = {
            let label = UILabel()
            
            label.textAlignment = .center
            label.textColor = .black
            label.font = label.font.withSize(55)
            label.text = "_ _"
            
            return label
        }()
        
        // 최저, 최고 온도 구현로직
        let titleInmaxTempStackView = CustomTempStackView().tempSetting(tempName: "최고", tempNameColor: .black, lat: self.lat, lon: self.lon)
        let titleInminTempStackView = CustomTempStackView().tempSetting(tempName: "최저", tempNameColor: .black, lat: self.lat, lon: self.lon)
        
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
            stackView.spacing = 10
            stackView.alignment = .center
            stackView.distribution = .equalSpacing
            
            return stackView
        }()
        
        // 체감온도 구현 로직
        let titleInBottomStackView = CustomTempStackView().tempSetting(tempName: "체감온도", tempNameColor: .black, lat: self.lat, lon: self.lon)
        
        let greetingLabel: UILabel = {
            let label = UILabel()
            
            label.text = greetingArr.shuffled().first
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 0
            label.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
            label.font = UIFont(name: "GmarketSansTTFLight", size: 12)
            
            return label
        }()
        
        let titleView: UIView = {
            let view = UIView()
            
            view.layer.cornerRadius = 10
            
            view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            view.addSubview(titleInImageView)
            view.addSubview(titleInWeatherTextLabel)
            view.addSubview(titleInTopTempStackView)
            view.addSubview(titleInBottomStackView)
            view.addSubview(greetingLabel)
            
            return view
        }()
        
        titleInImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleInWeatherTextLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            
            make.leading.equalTo(titleInImageView.snp.leading)
            make.bottom.equalToSuperview().offset(-30)
        }
        
        titleInTopTempStackView.snp.makeConstraints { make in
            make.top.equalTo(titleInImageView.snp.top)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        titleInBottomStackView.snp.makeConstraints { make in
            make.top.equalTo(titleInTopTempStackView.snp.bottom).offset(10)
            make.centerX.equalTo(titleInTopTempStackView.snp.centerX)
        }
        
        greetingLabel.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.top.equalTo(titleInBottomStackView.snp.bottom).offset(20)
            make.trailing.equalTo(titleInTopTempStackView)

        }
        
        //MARK: - TitleView 데이터 로직
        
        // 현재 온도 구현 로직
        WeatherAPIService.currentWeather(baseDate: DateValue.baseDate, baseTime: DateValue.baseTime, lat: self.lat, lon: self.lon) { response in
            var index = 0
            let difference = abs(Int(DateValue.currentTime)! - Int(DateValue.baseTime)!)
            
            if difference == 2300 || difference == 100 {
                index = 0
            } else if difference == 2200 || difference == 200 {
                index = 12
            } else if difference == 2100 || difference == 300 {
                index = 24
            }
            
            if let currentTmp = response.response?.body?.items.item[index].fcstValue {
                // 현재온도
                titleInTempNum.text = currentTmp + "˚"
            } else { titleInTempNum.text = "_ _" }
        }
        
        // 날씨상태 구현 로직
        WeatherAPIService.lookWeather(baseDate: DateValue.baseDate, baseTime: DateValue.baseTime, lat: self.lat, lon: self.lon) { response in
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
                titleInImageView.contentMode = .scaleAspectFit
                titleInImageView.tintColor = UIColor(named: "SunnyColor")
                
                titleInWeatherTextLabel.text = "맑음"
                
                self.view.backgroundColor = UIColor(named: "SunnyColor")
            } else if sky == "3" { // 구름 많음
                titleInImageView.image = UIImage(systemName: "smoke.fill")
                titleInImageView.contentMode = .scaleAspectFit
                titleInImageView.tintColor = UIColor(named: "manyCloudColor")
                
                titleInWeatherTextLabel.text = "대체로 흐림"
                
                self.view.backgroundColor = UIColor(named: "manyCloudColor")
            } else if sky == "4" && pty == "0" { // 흐림
                titleInImageView.image = UIImage(systemName: "cloud.fill")
                titleInImageView.contentMode = .scaleAspectFit
                titleInImageView.tintColor = UIColor(named: "CloudyColor")
                
                titleInWeatherTextLabel.text = "흐림"
                
                self.view.backgroundColor = UIColor(named: "CloudyColor")
                
            } else {
                if pty == "1" { // 비
                    titleInImageView.image = UIImage(systemName: "cloud.rain.fill")
                    titleInImageView.contentMode = .scaleAspectFit
                    titleInImageView.tintColor = UIColor(named: "RainyColor")
                    
                    titleInWeatherTextLabel.text = "비"
                    
                    self.view.backgroundColor = UIColor(named: "RainyColor")
                } else if pty == "2" { // 비/눈
                    titleInImageView.image = UIImage(systemName: "cloud.hail.fill")
                    titleInImageView.contentMode = .scaleAspectFit
                    titleInImageView.tintColor = UIColor(named: "RainAndSnowColor")
                    
                    titleInWeatherTextLabel.text = "눈·비"
                    
                    self.view.backgroundColor = UIColor(named: "RainAndSnowColor")
                } else if pty == "3" { // 눈
                    titleInImageView.image = UIImage(systemName: "snowflake")
                    titleInImageView.contentMode = .scaleAspectFit
                    titleInImageView.tintColor = UIColor(named: "SnowColor")
                    
                    titleInWeatherTextLabel.text = "눈"
                    
                    self.view.backgroundColor = UIColor(named: "SnowColor")
                } else if pty == "4" { // 소나기
                    titleInImageView.image = UIImage(systemName: "cloud.rain.fill")
                    titleInImageView.contentMode = .scaleAspectFit
                    titleInImageView.tintColor = UIColor(named: "SuddenRainColor")
                    
                    titleInWeatherTextLabel.text = "소나기"
                    
                    self.view.backgroundColor = UIColor(named: "SuddenRainColor")
                }
            }
            
        }
        return titleView
    }
}
