//
//  SideMenuViewController.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/19.
//

import UIKit

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("SideMenuViewController - viewDidLoad() called")
        
        self.view.backgroundColor = .lightGray
        
        sideVCLayoutSetting()
    }
    
    func sideVCLayoutSetting() {
        
        let topView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .systemBlue
            
            return view
        }()
        self.view.addSubview(topView)
        
        let citiesListBtn: UIButton = {
            let button = UIButton()
            
            button.backgroundColor = UIColor.white
            button.setTitleColor(.darkGray, for: .normal)
            button.setTitle("관심지역 목록/삭제", for: .normal)
            
            button.addTarget(self, action: #selector(citiesListBtnClicked), for: .touchUpInside)
            
            return button
        }()
        self.view.addSubview(citiesListBtn)
        
        let standardWHOBtn: UIButton = {
            let button = UIButton()
            
            button.backgroundColor = UIColor.white
            button.setTitleColor(.darkGray, for: .normal)
            button.setTitle("세계보건기구(WHO) 기준", for: .normal)
            
            button.addTarget(self, action: #selector(standardWHOBtnClicked), for: .touchUpInside)
            
            return button
        }()
        self.view.addSubview(standardWHOBtn)
        
        let settingBtn: UIButton = {
            let button = UIButton()
            
            button.backgroundColor = UIColor.white
            button.setTitleColor(.darkGray, for: .normal)
            button.setTitle("설정", for: .normal)
            
            button.addTarget(self, action: #selector(settingBtnClicked), for: .touchUpInside)
            
            return button
        }()
        self.view.addSubview(settingBtn)
        
        topView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        citiesListBtn.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        standardWHOBtn.snp.makeConstraints { make in
            make.height.equalTo(citiesListBtn.snp.height)
            make.top.equalTo(citiesListBtn.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        settingBtn.snp.makeConstraints { make in
            make.height.equalTo(standardWHOBtn.snp.height)
            make.top.equalTo(standardWHOBtn.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
    @objc func citiesListBtnClicked(_ sender: UIButton) {
        print("citiesListBtnClicked clicked")
        present(CityListViewController(), animated: true)
    }

    @objc func standardWHOBtnClicked(_ sender: UIButton) {
        print("standardWHOBtnClicked")
    }
    
    @objc func settingBtnClicked(_ sender: UIButton) {
        print("settingBtnClicked")
    }
}
