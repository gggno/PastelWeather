//
//  MainPageViewController.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/11.
//

import UIKit
import SnapKit
import CoreLocation

class MainPageViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
   
    lazy var firstVC: UIViewController = {
        let mainVC = MainViewController()
        // 첫번째 뷰인 것을 확인하는 용도
        mainVC.firstViewConfirm = true
        
        let vc = UINavigationController(rootViewController: mainVC)
        
        return vc
    }()
  
    override func viewWillAppear(_ animated: Bool) {
        print("MainPageViewController viewWillAppear() called")
        super.viewWillAppear(animated)
        updatePageView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("MainPageViewController viewWillDisAppear() called")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainPageViewController viewDidLoad() called")
        AddedCityDatas.shared.vcDatas.append(firstVC)
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
    
    func updatePageView() {
        pageViewController.delegate = self
        pageViewController.dataSource = self

        if let firstVC = AddedCityDatas.shared.vcDatas.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    // 페이지 화면 추가 함수
    @objc func deliveredVC(_ notification: NSNotification) {
        print("deliveredVC() called")
        guard let mainVC = notification.object as? MainViewController else {return}
        print("mainVC lat lon: \(mainVC.lat) \(mainVC.lon)")
        print("mainVC Double lat lon: \(mainVC.doubleLat) \(mainVC.doubleLon)")
        
        let naviVC = UINavigationController(rootViewController: mainVC)
        AddedCityDatas.shared.vcDatas.append(naviVC)
    }
    
    // 페이지 화면 삭제 함수
    @objc func deletePageVC(_ notification: NSNotification) {
        print("deletePageVC() called")
        if let indexpathRow = notification.object {
            pageViewController.delegate = self
            pageViewController.dataSource = self
            print(AddedCityDatas.shared.cityNameDatas)

            AddedCityDatas.shared.vcDatas.remove(at: indexpathRow as! Int)
            if let firstVC = AddedCityDatas.shared.vcDatas.first {
                pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
            }
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
