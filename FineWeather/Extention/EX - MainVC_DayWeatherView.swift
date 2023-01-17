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
        
        // MARK: - DayWeatherView UI 로직
        let dayInstackView1 = CustomDayStackView().dayStackViewSetting(time: "오후 9시", image: "cloud.heavyrain.fill", tmp: "-11")
        let dayInstackView2 = CustomDayStackView().dayStackViewSetting(time: "오후 10시", image: "sun.max.fill", tmp: "-12")
        let dayInstackView3 = CustomDayStackView().dayStackViewSetting(time: "오후 11시", image: "sun.max.fill", tmp: "-13")
        let dayInstackView4 = CustomDayStackView().dayStackViewSetting(time: "오전 01시", image: "sun.max.fill", tmp: "-14")
        let dayInstackView5 = CustomDayStackView().dayStackViewSetting(time: "오전 02시", image: "sun.max.fill", tmp: "-14")
        let dayInstackView6 = CustomDayStackView().dayStackViewSetting(time: "오전 03시", image: "sun.max.fill", tmp: "-15")
        let dayInstackView7 = CustomDayStackView().dayStackViewSetting(time: "오전 04시", image: "sun.max.fill", tmp: "-15")
        
        let hstackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [dayInstackView1, dayInstackView2, dayInstackView3, dayInstackView4, dayInstackView5, dayInstackView6, dayInstackView7])
            
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
            
            view.addSubview(dayInScrollView)
            
            return view
        }()
        
        dayInstackView1.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
        
        hstackView.snp.makeConstraints { make in
            make.height.equalTo(dayInScrollView.frameLayoutGuide.snp.height)
            make.edges.equalTo(dayInScrollView.contentLayoutGuide.snp.edges)
        }
        
        dayInScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // MARK: - DayWeatherView 데이터 로직
        
        
        
        
        return dayWeatherView
    }
    
}
