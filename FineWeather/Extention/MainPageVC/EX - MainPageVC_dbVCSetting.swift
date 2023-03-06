//
//  MainPageVC_dbVCSetting.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/14.
//

import UIKit
import Foundation
import RealmSwift

extension MainPageViewController {
    
    func dbVCSetting() -> [UIViewController] {
        print("MainPageViewController - dbVCLocationSetting() called")
        
        var vcArray: [UIViewController] = []
        
        let dbResult = realm.objects(LocalDB.self)
        
        // 로컬 DB에서 저장된 값 불러오기
        for dbData in dbResult {
            if dbData.currentVCConfirm == true { // 현재 위치 뷰면 건너뛰기
                continue
            } else  {
                let mainVC = MainViewController()
                
                mainVC.lat = dbData.lat
                mainVC.lon = dbData.lon
                mainVC.doubleLat = dbData.doubleLat
                mainVC.doubleLon = dbData.doubleLon
                mainVC.title = dbData.cityName
                
                let vc = UINavigationController(rootViewController: mainVC)
                vcArray.append(vc)
            }
        }
        return vcArray
    }
    
    func dbVCAppend(viewcontrollers: [UIViewController]) {
        print("MainPageViewController - dbVCAppend() called")
        for vc in viewcontrollers {
            AddedCityDatas.shared.vcDatas.append(vc)
        }
    }
    
}
