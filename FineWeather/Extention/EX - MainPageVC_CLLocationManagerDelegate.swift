//
//  EX - MainPageVC_CLLocationManagerDelegate.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/14.
//

import UIKit
import Foundation
import CoreLocation
import RealmSwift

extension MainPageViewController {
    
    func dbVCSetting() -> [UIViewController] {
        print("MainPageViewController - dbVCLocationSetting() called")
        
        var vcArray: [UIViewController] = []
        let dbResult = realm.objects(LocalDB.self).dropFirst()
        
        for dbData in dbResult {
            let mainVC = MainViewController()
            
            mainVC.lat = dbData.lat
            mainVC.lon = dbData.lon
            mainVC.doubleLat = dbData.doubleLat
            mainVC.doubleLon = dbData.doubleLon
            mainVC.title = dbData.cityName
            
            mainVC.dbViewConfirm = true
            
            let vc = UINavigationController(rootViewController: mainVC)
            vcArray.append(vc)
        }
        return vcArray
    }
    
    func dbVCAppend(viewcontrollers: [UIViewController]) {
        for vc in viewcontrollers {
            AddedCityDatas.shared.vcDatas.append(vc)
        }
    }
    
}
