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
    
    var bottomBarBannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBarBannerView = GADBannerView(adSize: GADAdSizeBanner)
        bottomBarBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bottomBarBannerView.rootViewController = self
        //        bottomBarBannerView.load(GADRequest())
        
        
        self.view.backgroundColor = .systemYellow
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // 타이틀에 현재위치 출력
        guard let currentLocation = locationManager.location else {return}
        convertAddress(from: currentLocation)
        
        let xy = convertGrid(code: "toXY", v1: locationManager.location?.coordinate.latitude ?? 0.0, v2: locationManager.location?.coordinate.longitude ?? 0.0)
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
        
        let googleAdsView1: UIView = {
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
            
            view.backgroundColor = .brown
            view.addSubview(titleView)
            view.addSubview(dayWeatherView)
            view.addSubview(googleAdsView1)
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
        dayWeatherView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        googleAdsView1.snp.makeConstraints { make in
            make.height.equalTo(340)
            make.top.equalTo(dayWeatherView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        emptyView4.snp.makeConstraints { make in
            make.height.equalTo(440)
            make.top.equalTo(googleAdsView1.snp.bottom).offset(40)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Note loadBannerAd is called in viewDidAppear as this is the first time that
        // the safe area is known. If safe area is not a concern (e.g., your app is
        // locked in portrait mode), the banner can be loaded in viewWillAppear.
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
        // Step 2 - Determine the view width to use for the ad width.
        let frame = { () -> CGRect in
            // Here safe area is taken into account, hence the view frame is used
            // after the view has been laid out.
            if #available(iOS 11.0, *) {
                return view.frame.inset(by: view.safeAreaInsets)
            } else {
                return view.frame
            }
        }()
        let viewWidth = frame.size.width
        
        // Step 3 - Get Adaptive GADAdSize and set the ad view.
        // Here the current interface orientation is used. If the ad is being preloaded
        // for a future orientation change or different orientation, the function for the
        // relevant orientation should be used.
        bottomBarBannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        
        // Step 4 - Create an ad request and load the adaptive banner ad.
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
