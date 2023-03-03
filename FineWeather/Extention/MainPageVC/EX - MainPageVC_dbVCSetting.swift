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
    
    func currentVCIndbVCSetting() -> [UIViewController] {
        print("MainPageViewController - dbVCLocationSetting() called")
        
        var vcArray: [UIViewController] = []
        // 첫번째(현재 위치)는 firstView로 만드니까 건너뛰고 그 이후부터 데이터 조회
        let dbResult = realm.objects(LocalDB.self).dropFirst()
        
        // 로컬 DB에서 저장된 값 불러오기
        for dbData in dbResult {
            let mainVC = MainViewController()
            
            mainVC.lat = dbData.lat
            mainVC.lon = dbData.lon
            mainVC.doubleLat = dbData.doubleLat
            mainVC.doubleLon = dbData.doubleLon
            mainVC.title = dbData.cityName
            
            let vc = UINavigationController(rootViewController: mainVC)
            vcArray.append(vc)
        }
        return vcArray
    }
    
    func currentVCNotIndbVCSetting() -> [UIViewController] {
        print("MainPageViewController - dbVCLocationSetting() called")
        
        var vcArray: [UIViewController] = []
        // 현재위치가 없으니까 모두 조회
        let dbResult = realm.objects(LocalDB.self)
        
        // 로컬 DB에서 저장된 값 불러오기
        for dbData in dbResult {
            let mainVC = MainViewController()
            
            mainVC.lat = dbData.lat
            mainVC.lon = dbData.lon
            mainVC.doubleLat = dbData.doubleLat
            mainVC.doubleLon = dbData.doubleLon
            mainVC.title = dbData.cityName
            
            let vc = UINavigationController(rootViewController: mainVC)
            vcArray.append(vc)
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
