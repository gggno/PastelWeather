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
        let titleView = titleViewSetting(presentImage: "sun.max.fill", presentText: "맑음", presentTmp: "-9", maxTmp: "-7", minTmp: "-13", fellTmp: "-20")
        
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
        
        titleView.snp.makeConstraints { make in
            make.size.equalTo(170)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(30)
        }
        
        titleView2.snp.makeConstraints { make in
            make.size.equalTo(240)
            make.top.equalTo(titleView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        titleView3.snp.makeConstraints { make in
            make.size.equalTo(340)
            make.top.equalTo(titleView2.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(20)
        }
        
        titleView4.snp.makeConstraints { make in
            make.size.equalTo(440)
            make.top.equalTo(titleView3.snp.bottom).offset(40)
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
