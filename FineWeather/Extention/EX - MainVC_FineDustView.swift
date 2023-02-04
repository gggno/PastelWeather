//
//  EX - MainVC_FineDustView.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/01.
//

import Foundation

// 카카오 -> 측정소 -> 미세먼지
extension MainViewController {
    
    func fineDustViewSetting() {
        
        //MARK: - FineDustView UI 로직
        
        
        
        
        
        
        
        
        
        
        //MARK: - FineDustView 데이터 로직
        let fineDustAPI = FineDustAPI()
        
        fineDustAPI.getTMInKakao(lat: self.doubleLat, lon: self.doubleLon) { response in // 1
            print("getTMInKakao: \(response)")
            fineDustAPI.getNearCenter(tmX: response.longitude, tmY: response.latitude) { response in // 2
                fineDustAPI.getFindDust(stationName: response) { pm10Value, pm10Grade, pm25Value, pm25Grade in // 3
                    print("MainVC: \(pm10Value), \(pm10Grade), \(pm25Value), \(pm25Grade)")
                }
            }
        }
    }
}
