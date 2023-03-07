//
//  MainViewController.swift
//  PastelWeather
//
//  Created by 정근호 on 2022/12/15.
//

import UIKit
import SnapKit
import Alamofire
import CoreLocation
import GoogleMobileAds
import RealmSwift

class MainViewController: UIViewController {
    
    let realm = try! Realm()
    
    let locationManager = CLLocationManager()
    
    var lat = 0 // 주소 조회, 온도 조회 때 사용
    var lon = 0 // 주소 조회, 온도 조회 때 사용
    var doubleLat = 0.0 // 미세먼지 조회 때 사용
    var doubleLon = 0.0 // 미세먼지 조회 때 사용
    
    var firstViewConfirm: Bool = false // 첫번째뷰(현재 위치)확인 때 사용
    var gpsNotDeterminedComfirm: Bool = false // GPS가 확인되지 않을 때 사용

    private let naverUrl = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc"
    private let kakaoUrl = "https://dapi.kakao.com/v2/local/geo/transcoord.json"
    private let nearCenterUrl = "http://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getNearbyMsrstnList"
    private let fineDustInfoUrl = "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"
    
    // 하단바 광고
    var bottomBarBannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        
        // 하단바 광고
        bottomBarBannerView = GADBannerView(adSize: GADAdSizeBanner)
        bottomBarBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bottomBarBannerView.rootViewController = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // 첫번째 뷰 현재위치를 기반으로 세팅
        if firstViewConfirm == true {
            firstVCLocationSetting()
        }
        
        // MARK: - 메인화면 내비게이션 요소 설정
        navigationItemSetting()
        
        // MARK: - 메인 스크롤뷰에 넣을 요소 설정
        mainVCLayoutSetting()
        
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
    
    func navigationItemSetting() {
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
    }
    
    func mainVCLayoutSetting() {
        // MARK: - titleView 요소 설정
        let titleView = titleViewSetting()
        
        // MARK: - dayWeatherView 요소 설정
        let dayWeatherView = DayWeatherViewSetting()
        
        // MARK: - fineDustView 요소 설정
        let fineDustView = fineDustViewSetting()
        
        let copyrightUsedInfoLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textColor = .white
            label.text = "자료: 기상청, 한국환경공단\n\n이 자료는 인증 받지 않은 실시간 자료이므로 자료 오류 및 표출방식에 따른 값이 다를 수 있거나 정보 제공이 불가할 수 있습니다."
            label.font = UIFont(name: "GmarketSansTTFMedium", size: 10)
            label.textAlignment = .center
            
            return label
        }()
        
        let containerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .clear
            
            view.addSubview(titleView)
            view.addSubview(dayWeatherView)
            view.addSubview(fineDustView)
            view.addSubview(copyrightUsedInfoLabel)
            
            return view
        }()
        
        // MARK: - 메인 스크롤뷰에 넣을 요소 레이아웃
        
        // MARK: - titleView 요소 레이아웃
        titleView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(30)
        }
        
        // MARK: - dayWeatherView 요소 레이아웃
        dayWeatherView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(50 )
            make.leading.equalToSuperview().offset(20)
        }
        
        // MARK: - fineDustView 요소 레이아웃
        fineDustView.snp.makeConstraints { make in
            
            make.top.equalTo(dayWeatherView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
           
        // MARK: - copyrightUsedInfoLabel 요소 레이아웃
        copyrightUsedInfoLabel.snp.makeConstraints { make in
            
            make.top.equalTo(fineDustView.snp.bottom).offset(40)
            make.leading.trailing.equalTo(fineDustView)
            make.bottom.equalToSuperview().offset(-100)
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
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func firstVCLocationSetting() {
        print("MainViewController - firstVCLocationSetting() called")
        // 타이틀에 현재위치 출력
        guard let currentLocation = locationManager.location else {return}
        convertCurrentAddress(from: currentLocation)
        
        let xy = convertGrid(code: "toXY", v1: locationManager.location?.coordinate.latitude ?? 0.0, v2: locationManager.location?.coordinate.longitude ?? 0.0)
        doubleLat = xy["lat"] ?? 60
        doubleLon = xy["lon"] ?? 126
        lat = Int(xy["nx"] ?? 60) // 기본값은 서울특별시
        lon = Int(xy["ny"] ?? 126) // 용산구
        
        print("convertGrid: \(convertGrid(code: "toXY", v1: locationManager.location?.coordinate.latitude ?? 0.0, v2: locationManager.location?.coordinate.longitude ?? 0.0))")
        print("int lat: \(lat), int lon: \(lon)")
        
        let dbDatas = realm.objects(LocalDB.self)
        let currentDB = LocalDB()
        
        currentDB.lat = lat
        currentDB.lon = lon
        currentDB.doubleLat = doubleLat
        currentDB.doubleLon = doubleLon
        currentDB.currentVCConfirm = true
        
        if dbDatas.isEmpty { // DB에 값이 아무것도 없을때
            print("first type 0")
            try! realm.write{
                realm.add(currentDB)
                print(dbDatas)
                print("로컬 DB 데이터 추가")
            }
        } else {
            try! realm.write{ // 그 이후 현재 위치의 저장값 변경
                if let filterData = realm.objects(LocalDB.self).filter("currentVCConfirm == true").first { // 현재위치가 있으면(gps가 켜져있으면) 저장된 현재위치의 데이터 실시간 업데이트
                    print("first type 1")
                    print(filterData)
                    
                    filterData.lat = lat
                    filterData.lon = lon
                    filterData.doubleLat = doubleLat
                    filterData.doubleLon = doubleLon
                    // city는 주소 찾는 함수에서 함
                    print(dbDatas)
                    
                } else { // 첫번째에 현재위치 데이터가 없어서 첫번째로 변경 (여기부터 아래까지는 현재위치가 없을때, gps가 꺼져있다가 켜진상태이면)
                    print("first type 2")
                    print("dbCount: \(dbDatas.count)")
                    
                    // 순서: 마지막 행 데이터 저장 -> 저장된 데이터 행 하나씩 움직임 -> 첫번째 데이터 업데이트 -> 마지막 행 add
                    if dbDatas.count > 1 { // 로컬 DB 데이터가 2개 이상일떄
                        let lastData = LocalDB()
                        
                        // 로컬 DB에 저장되어 있는 마지막 데이터를 lastDB변수에 저장
                        lastData.lat = dbDatas[dbDatas.count-1].lat
                        lastData.lon = dbDatas[dbDatas.count-1].lon
                        lastData.doubleLat = dbDatas[dbDatas.count-1].doubleLat
                        lastData.doubleLon = dbDatas[dbDatas.count-1].doubleLon
                        lastData.cityName = dbDatas[dbDatas.count-1].cityName
                        
                        // 저장된 데이터 행 하나씩 움직임
                        for index in (1...dbDatas.count-1).reversed() {
                            print("로컬 DB 데이터가 1개 이상일때 \(index)")
                            
                            dbDatas[index].lat = dbDatas[index-1].lat
                            dbDatas[index].lon = dbDatas[index-1].lon
                            dbDatas[index].doubleLat = dbDatas[index-1].doubleLat
                            dbDatas[index].doubleLon = dbDatas[index-1].doubleLon
                            dbDatas[index].cityName = dbDatas[index-1].cityName

                            print("for DbDatas: \(dbDatas)")
                        }
                        
                        // 첫번째 데이터 업데이트
                        dbDatas[0].lat = lat
                        dbDatas[0].lon = lon
                        dbDatas[0].doubleLat = doubleLat
                        dbDatas[0].doubleLon = doubleLon
                        dbDatas[0].currentVCConfirm = true
                        
                        // 마지막 행 add
                        realm.add(lastData)
                        print("lastData: \(lastData)")
                        print("final DbDatas: \(dbDatas)")
                    } else { // 로컬 DB 데이터가 1개일때(현재위치 데이터는 없음)
                        print("로컬 DB 데이터가 1개일떄")
                        let lastDB = LocalDB()
                        
                        // 로컬 DB에 저장되어 있는 데이터를 lastDB변수에 저장
                        lastDB.lat = dbDatas[0].lat
                        lastDB.lon = dbDatas[0].lon
                        lastDB.doubleLat = dbDatas[0].doubleLat
                        lastDB.doubleLon = dbDatas[0].doubleLon
                        lastDB.cityName = dbDatas[0].cityName
                        
                        // 현재위치 데이터를 첫번째 행으로 저장
                        dbDatas[0].lat = currentDB.lat
                        dbDatas[0].lon = currentDB.lon
                        dbDatas[0].doubleLat = currentDB.doubleLat
                        dbDatas[0].doubleLon = currentDB.doubleLon
                        dbDatas[0].cityName = currentDB.cityName
                        dbDatas[0].currentVCConfirm = true
                        
                        // 두번째 행에 lastDB add
                        realm.add(lastDB)
                        print(dbDatas)
                    }
                       
                }
            }
        }
    }
    
    func gpsNotDeterminedVCSetting() {
        print("MainViewController - gpsNotDeterminedVCSetting() called")

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
