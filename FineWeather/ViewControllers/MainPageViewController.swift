//
//  MainPageViewController.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/10.
//

import Foundation
import UIKit
import SnapKit

class MainPageViewController: UIViewController {
    
    var vcList: [MainViewController] = []
    
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        
        
        
    }
    
}

extension MainPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcList.firstIndex(of: MainViewController) else {return nil}
        
        let previousIndex = index -1
        
        if previousIndex < 0 || vcList.count <= previousIndex {
                    return nil
                }
                
                return vcList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        <#code#>
    }
    
    
    
}
