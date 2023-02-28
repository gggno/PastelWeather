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
        let stack7 = stackElement(timeLabel: dayInTimeLabel7, ImageView: dayInImageView7, tmpLabel: dayInTmpLabel7)
        let stack8 = stackElement(timeLabel: dayInTimeLabel8, ImageView: dayInImageView8, tmpLabel: dayInTmpLabel8)
        let stack9 = stackElement(timeLabel: dayInTimeLabel9, ImageView: dayInImageView9, tmpLabel: dayInTmpLabel9)
        let stack10 = stackElement(timeLabel: dayInTimeLabel10, ImageView: dayInImageView10, tmpLabel: dayInTmpLabel10)
        let stack11 = stackElement(timeLabel: dayInTimeLabel11, ImageView: dayInImageView11, tmpLabel: dayInTmpLabel11)
        let stack12 = stackElement(timeLabel: dayInTimeLabel12, ImageView: dayInImageView12, tmpLabel: dayInTmpLabel12)
        let stack13 = stackElement(timeLabel: dayInTimeLabel13, ImageView: dayInImageView13, tmpLabel: dayInTmpLabel13)
        let stack14 = stackElement(timeLabel: dayInTimeLabel14, ImageView: dayInImageView14, tmpLabel: dayInTmpLabel14)
        let stack15 = stackElement(timeLabel: dayInTimeLabel15, ImageView: dayInImageView15, tmpLabel: dayInTmpLabel15)
        let stack16 = stackElement(timeLabel: dayInTimeLabel16, ImageView: dayInImageView16, tmpLabel: dayInTmpLabel16)
        let stack17 = stackElement(timeLabel: dayInTimeLabel17, ImageView: dayInImageView17, tmpLabel: dayInTmpLabel17)
        let stack18 = stackElement(timeLabel: dayInTimeLabel18, ImageView: dayInImageView18, tmpLabel: dayInTmpLabel18)
        let stack19 = stackElement(timeLabel: dayInTimeLabel19, ImageView: dayInImageView19, tmpLabel: dayInTmpLabel19)
        let stack20 = stackElement(timeLabel: dayInTimeLabel20, ImageView: dayInImageView20, tmpLabel: dayInTmpLabel20)
        let stack21 = stackElement(timeLabel: dayInTimeLabel21, ImageView: dayInImageView21, tmpLabel: dayInTmpLabel21)
        let stack22 = stackElement(timeLabel: dayInTimeLabel22, ImageView: dayInImageView22, tmpLabel: dayInTmpLabel22)
        let stack23 = stackElement(timeLabel: dayInTimeLabel23, ImageView: dayInImageView23, tmpLabel: dayInTmpLabel23)
        let stack24 = stackElement(timeLabel: dayInTimeLabel24, ImageView: dayInImageView24, tmpLabel: dayInTmpLabel24)
        
        let stacks = UIStackView(arrangedSubviews: [stack1, stack2, stack3, stack4, stack5, stack6, stack7, stack8, stack9, stack10, stack11, stack12, stack13, stack14, stack15, stack16, stack17, stack18, stack19, stack20, stack21, stack22, stack23, stack24])
        
        weatherAPI.dayWeatherViewSetting(baseDate: DateValue.baseDate, baseTime: DateValue.baseTime, lat: lat, lon: lon) { response in
            print("세팅 날짜: \(DateValue.baseDate), 세팅 시간: \(DateValue.baseTime)")
            var index = 12
            let timeLeg = Int(DateValue.currentTime)! - Int(DateValue.baseTime)!
            print("timeLeg = \(Int(DateValue.currentTime)!) - \(Int(DateValue.baseTime)!)")
            
            // 시간 차이를 기준으로 인덱스 설정
            if timeLeg == 100 {
                print("timeLeg == 100")
                index = 0
            } else if timeLeg == 200 {
                print("timeLeg == 200")
                index = 12
            } else if timeLeg == 300 {
                print("timeLeg == 300")
                index = 24
            }
            
            for i in 0..<24 {
                var tmp = ""
                var sky = ""
                var pty = ""
                var weatherImageView = UIImageView()
                
                // TMN, TMX면 인덱스를 +1
                if response.response?.body?.items.item[index].category == "TMP" {
//                    print("i = response.response?.body?.items.item[\(index)](\(i+1))\nvalue = \(response.response?.body?.items.item[index])")
                    guard let tempTmp = response.response?.body?.items.item[index].fcstValue else {return}
                    tmp = tempTmp
                    guard let tempSky = response.response?.body?.items.item[index+5].fcstValue else {return}
                    sky = tempSky
                    guard let tempPty = response.response?.body?.items.item[index+6].fcstValue else {return}
                    pty = tempPty
                    
//                    print("tempSky = response.response?.body?.items.item[\(index+5)]\n value = \(response.response?.body?.items.item[index+5])")
//                    print("tempPty = response.response?.body?.items.item[\(index+6)]\n value = \(response.response?.body?.items.item[index+6])\n")
                    
                    // 날씨 설정
                    if sky == "1" { // 맑음
                        weatherImageView.image = UIImage(systemName: "sun.max.fill")
                        weatherImageView.tintColor = UIColor(named: "SunnyColor")
                    } else if sky == "3" { // 구름 많음
                        weatherImageView.image = UIImage(systemName: "smoke.fill")
                        weatherImageView.tintColor = UIColor(named: "manyCloudColor")
                    } else if sky == "4" && pty == "0" { // 흐림
                        weatherImageView.image = UIImage(systemName: "cloud.fill")
                        weatherImageView.tintColor = UIColor(named: "CloudyColor")
                        
                    } else {
                        if pty == "1" { // 비
                            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
                            weatherImageView.tintColor = UIColor(named: "RainyColor")
                        } else if pty == "2" { // 비/눈
                            weatherImageView.image = UIImage(systemName: "cloud.hail.fill")
                            weatherImageView.tintColor = UIColor(named: "RainAndSnowColor")
                        } else if pty == "3" { // 눈
                            weatherImageView.image = UIImage(systemName: "snowflake")
                            weatherImageView.tintColor = UIColor(named: "SnowColor")
                        } else if pty == "4" { // 소나기
                            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
                            weatherImageView.tintColor = UIColor(named: "SuddenRainColor")
                        }
                    }
                    index += 12
                    
                } else {
                    index += 1
//                    print("i = response.response?.body?.items.item[\(index)](\(i+1))\nvalue = \(response.response?.body?.items.item[index])\n")
                    guard let tempTmp = response.response?.body?.items.item[index].fcstValue else {return}
                    tmp = tempTmp
                    guard let tempSky = response.response?.body?.items.item[index+5].fcstValue else {return}
                    sky = tempSky
                    guard let tempPty = response.response?.body?.items.item[index+6].fcstValue else {return}
                    pty = tempPty
                    
//                    print("tempSky = response.response?.body?.items.item[\(index+5)]\n value = \(response.response?.body?.items.item[index+5])")
//                    print("tempPty = response.response?.body?.items.item[\(index+6)]\n value = \(response.response?.body?.items.item[index+6])\n")
                    
                    if sky == "1" { // 맑음
                        weatherImageView.image = UIImage(systemName: "sun.max.fill")
                        weatherImageView.tintColor = UIColor(named: "SunnyColor")
                    } else if sky == "3" { // 구름 많음
                        weatherImageView.image = UIImage(systemName: "smoke.fill")
                        weatherImageView.tintColor = UIColor(named: "manyCloudColor")
                    } else if sky == "4" && pty == "0" { // 흐림
                        weatherImageView.image = UIImage(systemName: "cloud.fill")
                        weatherImageView.tintColor = UIColor(named: "CloudyColor")
                        
                    } else {
                        if pty == "1" { // 비
                            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
                            weatherImageView.tintColor = UIColor(named: "RainyColor")
                        } else if pty == "2" { // 비/눈
                            weatherImageView.image = UIImage(systemName: "cloud.hail.fill")
                            weatherImageView.tintColor = UIColor(named: "RainAndSnowColor")
                        } else if pty == "3" { // 눈
                            weatherImageView.image = UIImage(systemName: "snowflake")
                            weatherImageView.tintColor = UIColor(named: "SnowColor")
                        } else if pty == "4" { // 소나기
                            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")
                            weatherImageView.tintColor = UIColor(named: "SuddenRainColor")
                        }
                    }
                    index += 12
                }
               
                // 시간 별 날씨 데이터 업데이트
                switch i+1 {
                case 1:
                    self.dayInTimeLabel1.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView1.image = weatherImageView.image
                    self.dayInImageView1.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel1.text = tmp + "˚"
                case 2:
                    self.dayInTimeLabel2.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView2.image = weatherImageView.image
                    self.dayInImageView2.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel2.text = tmp + "˚"
                case 3:
                    self.dayInTimeLabel3.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView3.image = weatherImageView.image
                    self.dayInImageView3.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel3.text = tmp + "˚"
                case 4:
                    self.dayInTimeLabel4.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView4.image = weatherImageView.image
                    self.dayInImageView4.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel4.text = tmp + "˚"
                case 5:
                    self.dayInTimeLabel5.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView5.image = weatherImageView.image
                    self.dayInImageView5.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel5.text = tmp + "˚"
                case 6:
                    self.dayInTimeLabel6.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView6.image = weatherImageView.image
                    self.dayInImageView6.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel6.text = tmp + "˚"
                case 7:
                    self.dayInTimeLabel7.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView7.image = weatherImageView.image
                    self.dayInImageView7.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel7.text = tmp + "˚"
                case 8:
                    self.dayInTimeLabel8.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView8.image = weatherImageView.image
                    self.dayInImageView8.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel8.text = tmp + "˚"
                case 9:
                    self.dayInTimeLabel9.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView9.image = weatherImageView.image
                    self.dayInImageView9.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel9.text = tmp + "˚"
                case 10:
                    self.dayInTimeLabel10.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView10.image = weatherImageView.image
                    self.dayInImageView10.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel10.text = tmp + "˚"
                case 11:
                    self.dayInTimeLabel11.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView11.image = weatherImageView.image
                    self.dayInImageView11.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel11.text = tmp + "˚"
                case 12:
                    self.dayInTimeLabel12.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView12.image = weatherImageView.image
                    self.dayInImageView12.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel12.text = tmp + "˚"
                case 13:
                    self.dayInTimeLabel13.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView13.image = weatherImageView.image
                    self.dayInImageView13.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel13.text = tmp + "˚"
                case 14:
                    self.dayInTimeLabel14.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView14.image = weatherImageView.image
                    self.dayInImageView14.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel14.text = tmp + "˚"
                case 15:
                    self.dayInTimeLabel15.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView15.image = weatherImageView.image
                    self.dayInImageView15.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel15.text = tmp + "˚"
                case 16:
                    self.dayInTimeLabel16.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView16.image = weatherImageView.image
                    self.dayInImageView16.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel16.text = tmp + "˚"
                case 17:
                    self.dayInTimeLabel17.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView17.image = weatherImageView.image
                    self.dayInImageView17.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel17.text = tmp + "˚"
                case 18:
                    self.dayInTimeLabel18.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView18.image = weatherImageView.image
                    self.dayInImageView18.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel18.text = tmp + "˚"
                case 19:
                    self.dayInTimeLabel19.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView19.image = weatherImageView.image
                    self.dayInImageView19.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel19.text = tmp + "˚"
                case 20:
                    self.dayInTimeLabel20.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView20.image = weatherImageView.image
                    self.dayInImageView20.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel20.text = tmp + "˚"
                case 21:
                    self.dayInTimeLabel21.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView21.image = weatherImageView.image
                    self.dayInImageView21.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel21.text = tmp + "˚"
                case 22:
                    self.dayInTimeLabel22.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView22.image = weatherImageView.image
                    self.dayInImageView22.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel22.text = tmp + "˚"
                case 23:
                    self.dayInTimeLabel23.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView23.image = weatherImageView.image
                    self.dayInImageView23.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel23.text = tmp + "˚"
                case 24:
                    self.dayInTimeLabel24.text = DateValue.currentTimeOfAmPm(count: Double(i+1))
                    self.dayInImageView24.image = weatherImageView.image
                    self.dayInImageView24.tintColor = weatherImageView.tintColor
                    
                    self.dayInTmpLabel24.text = tmp + "˚"
                default:
                    break
                }
            }
        }
        return stacks
    }
    
    // 라벨, 이미지를 위에 하나하나 할당한 다음 이 함수를 이용하여 스택뷰를 만든다.
    func stackElement(timeLabel: UILabel, ImageView: UIImageView, tmpLabel: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, ImageView, tmpLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        timeLabel.text = "정보 없음"
        ImageView.image = UIImage(systemName: "sun.max.fill")
        tmpLabel.text = "_ _"
        
        return stackView
    }
    
    // MARK: - 스택뷰 요소 할당(24개)
    let dayInTimeLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView1: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel1: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView2: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView3: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel3: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel4: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView4: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel4: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel5: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView5: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel5: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel6: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView6: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel6: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel7: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView7: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel7: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel8: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView8: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel8: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel9: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView9: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel9: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel10: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView10: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel10: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel11: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView11: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel11: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel12: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView12: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel12: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel13: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView13: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel13: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel14: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView14: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel14: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel15: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView15: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel15: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel16: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView16: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel16: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel17: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView17: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel17: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel18: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView18: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel18: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel19: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView19: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel19: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel20: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView20: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel20: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel21: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView21: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel21: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel22: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView22: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel22: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel23: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView23: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel23: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInTimeLabel24: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
    
    let dayInImageView24: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel24: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GmarketSansTTFMedium", size: 15)
        label.textColor = .black
        return label
    }()
}
