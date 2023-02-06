//
//  EX - MainVC_FineDustView.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/01.
//

import Foundation
import UIKit

// 카카오 -> 측정소 -> 미세먼지
extension MainViewController {
    
    func fineDustViewSetting() -> UIView {
        
        //MARK: - FineDustView UI 로직
        let pm10View = CustomView()
        let pm25View = CustomView()
        
        let vStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [pm10View, pm25View])
            
            stackView.axis = .vertical
            stackView.spacing = 30
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.backgroundColor = .darkGray
            
            return stackView
        }()
        
        let fineDustView: UIView = {
           let view = UIView()
            
            view.addSubview(vStackView)
            view.backgroundColor = .purple
            return view
        }()
        
        pm10View.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.width.equalToSuperview()
        }
        
        vStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        //MARK: - FineDustView 데이터 로직
        let fineDustAPI = FineDustAPI()
        
        fineDustAPI.getTMInKakao(lat: self.doubleLat, lon: self.doubleLon) { response in // 1
            fineDustAPI.getNearCenter(tmX: response.longitude, tmY: response.latitude) { response in // 2
                fineDustAPI.getFindDust(stationName: response) { pm10Value, pm10Grade, pm25Value, pm25Grade in // 3
                    print("MainVC: \(pm10Value), \(pm10Grade), \(pm25Value), \(pm25Grade)")
                    
                    let fineDustStandard = "~30 좋음, 31~80 보통, 81~150 나쁨 151~ 매우나쁨"
                    let fineDustProgress: Float = Float(pm10Value)! / 200 // 미세먼지 마지막 기준을 200으로 잡음
                    let ultrafineDustProgress: Float = Float(pm25Value)! / 120 // 초미세먼지 마지막 기준을 120으로 잡음
                    print("fineDustProgress: \(fineDustProgress)")
                    print("ultrafine dust: \(ultrafineDustProgress)")
                    // 미세먼지
                    switch Int(pm10Value)! {
                    case 0...30:
                        pm10View.setupLayout(title: "미세먼지", value: pm10Value, grade: pm10Grade, minValue: "0", currentState: "😁 좋음 \(pm10Value)")
                        pm10View.progressView.progressTintColor = .blue
                        pm10View.progressView.trackTintColor = .lightGray
                        pm10View.progressView.setProgress(fineDustProgress, animated: true)
                    case 31...80:
                        pm10View.setupLayout(title: "미세먼지", value: pm10Value, grade: pm10Grade, minValue: "0", currentState: "🙂 보통 \(pm10Value)")
                        pm10View.progressView.progressTintColor = .green
                        pm10View.progressView.trackTintColor = .lightGray
                        pm10View.progressView.setProgress(fineDustProgress, animated: true)
                    case 81...150:
                        pm10View.setupLayout(title: "미세먼지", value: pm10Value, grade: pm10Grade, minValue: "0", currentState: "☹️ 나쁨 \(pm10Value)")
                        pm10View.progressView.progressTintColor = .yellow
                        pm10View.progressView.trackTintColor = .lightGray
                        pm10View.progressView.setProgress(fineDustProgress, animated: true)
                    case 151...:
                        pm10View.setupLayout(title: "미세먼지", value: pm10Value, grade: pm10Grade, minValue: "0", currentState: "😡 매우나쁨 \(pm10Value)")
                        pm10View.progressView.progressTintColor = .red
                        pm10View.progressView.trackTintColor = .lightGray
                        pm10View.progressView.setProgress(fineDustProgress, animated: true)
                    default:
                        pm10View.setupLayout(title: "미세먼지", value: "0", grade: "0", minValue: "0", currentState: "정보없음")
                    }
                    
                    // 초미세먼지
                    switch Int(pm25Value)! {
                    case 0...15:
                        pm25View.setupLayout(title: "초미세먼지", value: pm25Value, grade: pm25Grade, minValue: "0", currentState: "😁 좋음 \(pm25Value)")
                        pm25View.progressView.progressTintColor = .blue
                        pm25View.progressView.trackTintColor = .lightGray
                        pm25View.progressView.setProgress(ultrafineDustProgress, animated: true)
                    case 16...35:
                        pm25View.setupLayout(title: "초미세먼지", value: pm25Value, grade: pm25Grade, minValue: "0", currentState: "🙂 보통 \(pm25Value)")
                        pm25View.progressView.progressTintColor = .green
                        pm25View.progressView.trackTintColor = .lightGray
                        pm25View.progressView.setProgress(ultrafineDustProgress, animated: true)
                    case 36...75:
                        pm25View.setupLayout(title: "초미세먼지", value: pm25Value, grade: pm25Grade, minValue: "0", currentState: "☹️ 나쁨 \(pm25Value)")
                        pm25View.progressView.progressTintColor = .yellow
                        pm25View.progressView.trackTintColor = .lightGray
                        pm25View.progressView.setProgress(ultrafineDustProgress, animated: true)
                    case 76...:
                        pm25View.setupLayout(title: "초미세먼지", value: pm25Value, grade: pm25Grade, minValue: "0", currentState: "😡 매우나쁨 \(pm25Value)")
                        pm25View.progressView.progressTintColor = .red
                        pm25View.progressView.trackTintColor = .lightGray
                        pm25View.progressView.setProgress(ultrafineDustProgress, animated: true)
                    default:
                        pm25View.setupLayout(title: "초미세먼지", value: "0", grade: "0", minValue: "0", currentState: "정보없음")
                    }
                }
            }
        }
        return fineDustView
    }
}
