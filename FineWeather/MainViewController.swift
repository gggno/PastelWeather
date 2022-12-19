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
        self.title = "경기도 부천시"
        
        let titleView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .gray
            
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
            
            view.backgroundColor = .red
            view.addSubview(titleView)
            view.addSubview(titleView2)
            view.addSubview(titleView3)
            view.addSubview(titleView4)

            return view
        }()
        
        titleView.snp.makeConstraints { make in
            make.size.equalTo(180)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalTo(containerView.snp.leading).offset(30)
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
