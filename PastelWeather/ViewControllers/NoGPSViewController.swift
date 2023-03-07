//
//  NoGPSViewController.swift
//  PastelWeather
//
//  Created by 정근호 on 2023/03/07.
//

import UIKit
import SnapKit

class NoGPSViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        let alertController = UIAlertController (title: "위치정보 접근", message: "현재 위치에 접근할 수 있도록 설정에서 위치 정보 접근을 허용해주세요. 😁", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "설정", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .darkGray
        
        navigationItemSetting()
        noGPSVCLayoutSetting()
    }
    
    // 레이아웃 세팅
    func noGPSVCLayoutSetting() {
        let titleLabel: UILabel = {
            let label = UILabel()
            
            label.textColor = .white
            label.textAlignment = .center
            label.text = "여기는 어디인가요??"
            label.font = UIFont(name: "GmarketSansTTFMedium", size: 20)
            
            return label
        }()
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
        }
        
        let guideInfo: UILabel = {
            let label = UILabel()
            
            label.numberOfLines = 0
            label.textColor = .white
            label.text = "현재 위치 날씨를 표시할 수 없습니다.\n내 기기 위치에 접근할 수 있도록 설정에서 위치 정보 접근을 허용해주세요. 😢"
            label.font = UIFont(name: "GmarketSansTTFLight", size: 15)
            
            return label
        }()
        self.view.addSubview(guideInfo)
        
        guideInfo.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalTo(20)
        }
        
        let questionMark: UILabel = {
            let label = UILabel()
            
            label.textColor = .white
            label.text = "?"
            label.font = UIFont(name: "GmarketSansTTFLight", size: 400)
            
            return label
        }()
        self.view.addSubview(questionMark)
        
        questionMark.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(guideInfo.snp.bottom).offset(50)
        }
        
    }
    
    // 내비게이션 요소 세팅
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
