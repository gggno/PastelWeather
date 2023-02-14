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
    
    lazy var firstVC: UIViewController = {
        let mainVC = MainViewController()
        // 첫번째 뷰인 것을 확인하는 용도
        mainVC.firstViewConfirm = true
        
        let vc = UINavigationController(rootViewController: mainVC)
        
        return vc
    }()
    
    lazy var vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        
        return vc
    }()
    
    lazy var dataViewControllers: [UIViewController] = {
        return [firstVC, vc2]
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initPageViewController()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(deliverdVC(_:)), name: NSNotification.Name("sendVC"), object: nil)
        
        
    }
    
    // 페이지뷰 설정
    func initPageViewController() {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        view.addSubview(pageViewController.view)
        self.addChild(pageViewController)
        // 1. 페이징 화면 추가 방법 구상
    }
    
    // 페이지 화면 추가 함수
    @objc func deliverdVC(_ notification: NSNotification) {
        guard let mainVC = notification.object as? MainViewController else {return}
        
        
        
        let naviVC = UINavigationController(rootViewController: mainVC)
        dataViewControllers.append(naviVC)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("sendVC"), object: nil)
    }
    
}

extension MainPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // 왼쪽에서 오른쪽으로 스와이프 직전에 실행되는 함수
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        print("before")
        guard let index = dataViewControllers.firstIndex(of: viewController) else {return nil}
        let previousIndex = index - 1
        
        if previousIndex < 0 {
            return nil
        } else {
            return dataViewControllers[previousIndex]
        }
    }
    
    // 오른쪽에서 왼쪽으로 스와이프 직전에 실행되는 함수
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        print("after")
        guard let index = dataViewControllers.firstIndex(of: viewController) else {return nil}
        let nextIndex = index + 1
        
        if nextIndex == dataViewControllers.count {
            return nil
        } else {
            return dataViewControllers[nextIndex]
        }
    }
}
