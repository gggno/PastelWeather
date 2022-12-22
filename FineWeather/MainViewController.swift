//
//  MainViewController.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/15.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

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
        
        // MARK: - 스크롤뷰에 넣을 요소 설정
        
        // MARK: - titleView 요소 설정
        let titleInImageView: UIImageView = {
            let imageView = UIImageView()
            
            imageView.image = UIImage(systemName: "sun.max.fill")
            imageView.backgroundColor = .white
            
            return imageView
        }()
        
        let titleInWeatherTextLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = .white
            label.text = "맑음"
            
            return label
        }()
        
        let titleInTempNum: UILabel = {
            let label = UILabel()
            label.backgroundColor = .magenta
            label.textAlignment = .center
            label.font = label.font.withSize(40)
            label.text = "-7"
            
            return label
        }()
        
        let titleInmaxTempStackView = CustomTempStackView().tempSetting(tempName: "최고", tempNameColor: .red, temp: "10도")
        let titleInminTempStackView = CustomTempStackView().tempSetting(tempName: "최저", tempNameColor: .blue, temp: "1도")
        
        let titleInTempStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleInmaxTempStackView, titleInminTempStackView])
            
            stackView.axis = .vertical
            stackView.spacing = 20
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            
            return stackView
        }()
        
        let titleInTopTempStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleInTempNum, titleInTempStackView])
            
            stackView.axis = .horizontal
            stackView.spacing = 20
            stackView.alignment = .center
            stackView.distribution = .equalSpacing
            
            return stackView
        }()
        
        let titleInBottomStackView = CustomTempStackView().tempSetting(tempName: "체감온도", tempNameColor: .white, temp: "-13도")
        
        
        let titleView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .systemCyan
            view.addSubview(titleInImageView)
            view.addSubview(titleInWeatherTextLabel)
            view.addSubview(titleInTopTempStackView)
            view.addSubview(titleInBottomStackView)
            
            return view
        }()
        
        let titleView2: UIView = {
            let view = UIView()
            
            view.backgroundColor = .gray
            
            return view
        }()
        
        let titleView3: UIView = {
            let view = UIView()
            
            view.backgroundColor = .gray
            
            return view
        }()
        
        let titleView4: UIView = {
            let view = UIView()
            
            view.backgroundColor = .gray
            
            return view
        }()
        
        let containerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .clear
            view.addSubview(titleView)
            view.addSubview(titleView2)
            view.addSubview(titleView3)
            view.addSubview(titleView4)

            return view
        }()
        
        titleInImageView.snp.makeConstraints { make in
            make.size.equalTo(90)
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        titleInWeatherTextLabel.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(30)
            make.leading.equalTo(titleInImageView.snp.leading)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        titleInTopTempStackView.snp.makeConstraints { make in
            make.top.equalTo(titleInImageView.snp.top)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        titleInBottomStackView.snp.makeConstraints { make in
            make.top.equalTo(titleInTopTempStackView.snp.bottom).offset(30)
            make.leading.equalTo(titleInTopTempStackView.snp.leading)
            make.trailing.equalTo(titleInTopTempStackView.snp.trailing)
        }
        
        titleView.snp.makeConstraints { make in
            make.size.equalTo(170)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        titleView2.snp.makeConstraints { make in
            make.size.equalTo(240)
            make.top.equalTo(titleView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(30)
        }
        
        titleView3.snp.makeConstraints { make in
            make.size.equalTo(340)
            make.top.equalTo(titleView2.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(30)
        }
        
        titleView4.snp.makeConstraints { make in
            make.size.equalTo(440)
            make.top.equalTo(titleView3.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(30)
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
