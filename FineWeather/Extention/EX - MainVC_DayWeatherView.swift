//
//  EX - MainVC_DayWeatherView.swift
//  FineWeather
//
//  Created by 정근호 on 2023/01/17.
//

import Foundation
import UIKit

// DayWeatherView 구성
extension MainViewController {
    
    func DayWeatherViewSetting() -> UIView {
        
        // MARK: - DayWeatherView 데이터 로직
        let dayInStackViews = CustomDayStackView().dayWeatherMakeStack(lat: self.lat, lon: self.lon)
        
        // MARK: - DayWeatherView UI 로직
        let hstackView: UIStackView = {
            let stackView = dayInStackViews
            
            stackView.axis = .horizontal
            stackView.spacing = 10
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            
            return stackView
        }()
        
        let dayInScrollView: UIScrollView = {
            let scrollView = UIScrollView()
            
            scrollView.alwaysBounceHorizontal = true
            scrollView.isUserInteractionEnabled = true
            
            scrollView.addSubview(hstackView)
            
            return scrollView
        }()
        
        let dayWeatherView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .systemGreen
            view.layer.cornerRadius = 10
            
            view.addSubview(dayInScrollView)
            
            return view
        }()
        
//        dayInstackView1.snp.makeConstraints { make in
//            make.width.equalTo(70)
//        }
        
        hstackView.snp.makeConstraints { make in
            make.height.equalTo(dayInScrollView.frameLayoutGuide.snp.height)
            make.edges.equalTo(dayInScrollView.contentLayoutGuide.snp.edges)
        }
        
        dayInScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return dayWeatherView
    }
    
}
