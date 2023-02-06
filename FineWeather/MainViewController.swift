//
//  MainViewController.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/15.
//

import UIKit
import SnapKit
import Alamofire
import GoogleMobileAds

class MainViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var lat = 0
    var lon = 0
    var doubleLat = 0.0
    var doubleLon = 0.0
    
    let naverUrl = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc"
    let kakaoUrl = "https://dapi.kakao.com/v2/local/geo/transcoord.json"
    let nearCenterUrl = "http://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getNearbyMsrstnList"
    let fineDustInfoUrl = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"
    
    // 하단바 광고
    var bottomBarBannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 하단바 광고
        bottomBarBannerView = GADBannerView(adSize: GADAdSizeBanner)
        bottomBarBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bottomBarBannerView.rootViewController = self
        
        self.view.backgroundColor = .systemYellow
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // 타이틀에 현재위치 출력
        guard let currentLocation = locationManager.location else {return}
        convertAddress(from: currentLocation)
        
        let xy = convertGrid(code: "toXY", v1: locationManager.location?.coordinate.latitude ?? 0.0, v2: locationManager.location?.coordinate.longitude ?? 0.0)
        doubleLat = xy["lat"] ?? 60
        doubleLon = xy["lon"] ?? 126
        lat = Int(xy["nx"] ?? 60) // 기본값은 서울특별시
        lon = Int(xy["ny"] ?? 126) // 용산구
        print("convertGrid: \(convertGrid(code: "toXY", v1: locationManager.location?.coordinate.latitude ?? 0.0, v2: locationManager.location?.coordinate.longitude ?? 0.0))")
        print("int lat: \(lat), int lon: \(lon)")
        
        // MARK: - 메인화면 내비게이션 요소 설정
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
        
        // MARK: - titleView 요소 설정
        let titleView = titleViewSetting()
        
        // MARK: - dayWeatherView 요소 설정
        let dayWeatherView = DayWeatherViewSetting()
        
        // MARK: - fineDustView 요소 설정
        let fineDustView = fineDustViewSetting()
        
        let emptyView4: UIView = {
            let view = UIView()
            
            view.backgroundColor = .gray
            
            return view
        }()
        
        let containerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .brown
            view.addSubview(titleView)
            view.addSubview(dayWeatherView)
            view.addSubview(fineDustView)
            view.addSubview(emptyView4)
            
            return view
        }()
        
        // MARK: - 메인 스크롤뷰에 넣을 요소 레이아웃
        
        // MARK: - titleView 요소 레이아웃
        titleView.snp.makeConstraints { make in
            make.height.equalTo(170)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(30)
        }
        
        // MARK: - dayWeatherView 요소 레이아웃
        dayWeatherView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        fineDustView.snp.makeConstraints { make in
            make.height.equalTo(350)
            make.top.equalTo(dayWeatherView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        emptyView4.snp.makeConstraints { make in
            make.height.equalTo(440)
            make.top.equalTo(fineDustView.snp.bottom).offset(40)
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
        
        // 하단바 광고 추가
        bannerViewDidReceiveAd(bottomBarBannerView)
    }
    
    // MARK: - 하단바 구글ads 맞춤 크기 설정
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadBannerAd()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to:size, with:coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.loadBannerAd()
        })
    }
    
    func loadBannerAd() {
        let frame = { () -> CGRect in
            if #available(iOS 11.0, *) {
                return view.frame.inset(by: view.safeAreaInsets)
            } else {
                return view.frame
            }
        }()
        let viewWidth = frame.size.width
        
        bottomBarBannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        
        bottomBarBannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
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
import CoreLocation

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
