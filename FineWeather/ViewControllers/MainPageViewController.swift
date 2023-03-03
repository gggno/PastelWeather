//
//  MainPageViewController.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/11.
//

import UIKit
import SnapKit
import RealmSwift
import CoreLocation

class MainPageViewController: UIViewController {
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    var locationManager: CLLocationManager!
    
    let realm = try! Realm()
    
    lazy var currentLocationVC: UIViewController = {
        let mainVC = MainViewController()
        // 첫번째 뷰인 것을 확인하는 용도
        mainVC.firstViewConfirm = true
        
        let vc = UINavigationController(rootViewController: mainVC)
        
        return vc
    }()
    
    lazy var gpsNotDeterminedVC: UIViewController = {
        let mainVC = MainViewController()
        // gps가 확인되지 않을 때를 확인하는 용도
        mainVC.gpsNotDeterminedComfirm = true
        
        let vc = UINavigationController(rootViewController: mainVC)
        
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainPageViewController viewDidLoad() called")
        requestGPSPermission()
        
//        AddedCityDatas.shared.vcDatas.append(currentLocationVC)
//        // 로컬 DB에 저장된 도시들 페이지뷰에 추가
//        dbVCAppend(viewcontrollers: dbVCSetting())
        
        initPageViewController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deliveredVC(_:)), name: NSNotification.Name("sendVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deletePageVC(_:)), name: NSNotification.Name("deleteVC"), object: nil)
    }
    
    // 페이지뷰 설정
    func initPageViewController() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        if let firstVC = AddedCityDatas.shared.vcDatas.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        view.addSubview(pageViewController.view)
        self.addChild(pageViewController)
    }
    
    // 페이지 화면 추가 함수
    @objc func deliveredVC(_ notification: NSNotification) {
        print("MainPageViewController - deliveredVC() called")
        guard let mainVC = notification.object as? MainViewController else {return}
        let naviVC = UINavigationController(rootViewController: mainVC)
        
        AddedCityDatas.shared.vcDatas.append(naviVC)
        
        // 추가한 도시의 뷰로 이동
        if let lastVC = AddedCityDatas.shared.vcDatas.last {
            pageViewController.setViewControllers([lastVC], direction: .forward, animated: true)
        }
    }
    
    // 페이지 화면 삭제 함수
    @objc func deletePageVC(_ notification: NSNotification) {
        print("MainPageViewController - deletePageVC() called")
        if let indexpathRow = notification.object {
            pageViewController.delegate = self
            pageViewController.dataSource = self
            
            AddedCityDatas.shared.vcDatas.remove(at: indexpathRow as! Int)
            
            if let firstVC = AddedCityDatas.shared.vcDatas.first {
                pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
            }
        }
    }
    
    func requestGPSPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS: 권한 있음")
            // 첫번째뷰(현재위치) 페이지뷰에 추가
            AddedCityDatas.shared.vcDatas.append(currentLocationVC)
            // 로컬 DB에 저장된 도시들 페이지뷰에 추가
            dbVCAppend(viewcontrollers: currentVCIndbVCSetting())
        case .restricted, .notDetermined:
            print("GPS: 아직 선택하지 않음")
            // 로컬 DB에 저장된 도시들 페이지뷰에 추가
            AddedCityDatas.shared.vcDatas.append(gpsNotDeterminedVC)
            dbVCAppend(viewcontrollers: currentVCNotIndbVCSetting())
        case .denied:
            print("GPS: 권한 없음")
            // 로컬 DB에 저장된 도시들 페이지뷰에 추가
            dbVCAppend(viewcontrollers: currentVCNotIndbVCSetting())
        default:
            print("GPS: Default")
            // 로컬 DB에 저장된 도시들 페이지뷰에 추가
            dbVCAppend(viewcontrollers: currentVCIndbVCSetting())
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("sendVC"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("deleteVC"), object: nil)
    }
    
}

extension MainPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // 왼쪽에서 오른쪽으로 스와이프 직전에 실행되는 함수
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("before")
        guard let index = AddedCityDatas.shared.vcDatas.firstIndex(of: viewController) else {return nil}
        let previousIndex = index - 1
        
        if previousIndex < 0 {
            return nil
        } else {
            return AddedCityDatas.shared.vcDatas[previousIndex]
        }
    }
    
    // 오른쪽에서 왼쪽으로 스와이프 직전에 실행되는 함수
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("after")
        guard let index = AddedCityDatas.shared.vcDatas.firstIndex(of: viewController) else {return nil}
        let nextIndex = index + 1
        
        if nextIndex == AddedCityDatas.shared.vcDatas.count {
            return nil
        } else {
            return AddedCityDatas.shared.vcDatas[nextIndex]
        }
    }
    
}
