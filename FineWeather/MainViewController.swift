//
//  MainViewController.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/15.
//

import UIKit
import SnapKit
import Alamofire

class MainViewController: UIViewController {
    
    var baseDate: String = {
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH00"
        
        // 현재시간이 0000~0200이면 전날 날짜의 2300시로 조회
        if formatter.string(from: time) == "0000" || formatter.string(from: time) == "0100" || formatter.string(from: time) == "0200" {
            let date = Date(timeIntervalSinceNow: -86400)
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYYMMdd"
            
            return formatter.string(from: date)
        }
        // 현재시간이 0300~2300이면 오늘 날짜의 0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300시로 조회
        else {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYYMMdd"
            
            return formatter.string(from: date)
        }
    }()
    
    var baseTime: String = {
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH00"
        
        switch Int(formatter.string(from: time))! {
        case 0000...0199:
            print("0000...0159")
            print("2300") // 어제 2300
            return "2300"
            
        case 0200...0499:
            print("0200...0459")
            print("0200")
            return "0200"
            
        case 0500...0799:
            print("0500...0759")
            print("0500")
            return "0500"

        case 0800...1099:
            print("0800...1059")
            print("0800")
            return "0800"

        case 1100...1399:
            print("1100...1359")
            print("1100")
            return "1100"

        case 1400...1699:
            print("1400...1659")
            print("1400")
            return "1400"

        case 1700...1999:
            print("1700...1959")
            print("1700")
            return "1700"

        case 2000...2299:
            print("2000...2259")
            print("2000")
            return "2000"

        case 2300...2359:
            print("2300...2359")
            print("2300") // 오늘 2300
            return "2300"

        default:
            print("default")
            return "0000"
        }
    }()
    
    var currentTime: String = {
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH00"
        
        return formatter.string(from: time)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemYellow
        
        // MARK: - 메인화면 내비게이션 요소 설정
        self.title = "경기도 부천시"
        
        self.navigationItem.leftBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(sideMenuBtnClicked(_:)))
            button.tintColor = .white
            
            return button
        }()
        
        self.navigationItem.rightBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusBtnClicked(_:)))
            button.tintColor = .white
            
            return button
        }()
        
        // MARK: - 메인 스크롤뷰에 넣을 요소 설정
        let weatherAPI = WeatherAPI()
        
        // MARK: - titleView 요소 설정
        
        let titleView = titleViewSetting(presentImage: "sun.max.fill", presentText: "맑음", maxTmp: "-7", minTmp: "-13", fellTmp: "-20") // 매개변수 다 제거할 예정
        
        // MARK: - dayWeatherView 요소 설정
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
        
        let emptyView3: UIView = {
            let view = UIView()
            
            view.backgroundColor = .gray
            
            return view
        }()
        
        let emptyView4: UIView = {
            let view = UIView()
            
            view.backgroundColor = .gray
            
            return view
        }()
        
        let containerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .clear
            view.addSubview(titleView)
            view.addSubview(dayWeatherView)
            view.addSubview(emptyView3)
            view.addSubview(emptyView4)
            
            return view
        }()
        
        // MARK: - 메인 스크롤뷰에 넣을 요소 레이아웃
        
        // MARK: - titleView 요소 레이아웃
        titleView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(30)
        }
        
        // MARK: - dayWeatherView 요소 레이아웃
        dayInstackView1.snp.makeConstraints { make in
            make.width.equalTo(70)
        }
        
        hstackView.snp.makeConstraints { make in
            make.height.equalTo(dayInScrollView.frameLayoutGuide.snp.height)
            make.edges.equalTo(dayInScrollView.contentLayoutGuide.snp.edges)
        }
        
        dayWeatherView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        dayInScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView3.snp.makeConstraints { make in
            make.height.equalTo(340)
            make.top.equalTo(dayWeatherView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        emptyView4.snp.makeConstraints { make in
            make.height.equalTo(440)
            make.top.equalTo(emptyView3.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.bottom.equalTo(containerView.snp.bottom).offset(-30)
        }
        
        let scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.alwaysBounceVertical = true // 항상 세로
            scroll.isUserInteractionEnabled = true // 사용자의 상호작용
            
            scroll.addSubview(containerView)
            
            return scroll
        }()
        
        self.view.addSubview(scrollView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide.snp.edges)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
    }
    
    // 버튼 클릭 메서드
    @objc func sideMenuBtnClicked(_ sender: UIButton) {
        print("MainVC - sideMenuBtnClicked() called")
        let sideMenu = SideMenuNavigation(rootViewController: SideMenuViewController())
        
        present(sideMenu, animated: true)
    }
    
    @objc func plusBtnClicked(_ sender: UIButton) {
        print("MainVC - plusBtnClicked() called")
        
        self.navigationController?.pushViewController(PlusViewController(), animated: true)
    }
    
}

#if DEBUG
import SwiftUI

struct MainViewControllerPresentable: UIViewControllerRepresentable {
    func  updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        MainViewController()
    }
}

struct MainViewControllerPresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        MainViewControllerPresentable()
            .previewDevice("iphone 12 mini")
            .previewDisplayName("iphone 12 mini")
            .ignoresSafeArea()
    }
}
#endif
