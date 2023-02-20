//
//  SideMenuNavigation.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/19.
//

import Foundation
import SideMenu

class SideMenuNavigation: SideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.leftSide = true
        
        self.presentationStyle = .menuSlideIn
    }
    
}
