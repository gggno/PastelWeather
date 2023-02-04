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
    
    func fineDustViewSetting() {
        
        //MARK: - FineDustView UI 로직
        let pm10View = CustomView()
        let pm25View = CustomView()
        
        
        //MARK: - FineDustView 데이터 로직
        let fineDustAPI = FineDustAPI()
        
        fineDustAPI.getTMInKakao(lat: self.doubleLat, lon: self.doubleLon) { response in // 1
            print("getTMInKakao: \(response)")
            fineDustAPI.getNearCenter(tmX: response.longitude, tmY: response.latitude) { response in // 2
                fineDustAPI.getFindDust(stationName: response) { pm10Value, pm10Grade, pm25Value, pm25Grade in // 3
                    print("MainVC: \(pm10Value), \(pm10Grade), \(pm25Value), \(pm25Grade)")
                    pm10View.setupLayout(title: "미세먼지", value: pm10Value, grade: pm10Grade)
                    pm25View.setupLayout(title: "초미세먼지", value: pm25Value, grade: pm25Grade)
                }
            }
        }
    }
}
