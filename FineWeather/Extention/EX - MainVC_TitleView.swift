//
//  EX - MainVC_TitleView.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/23.
//

import Foundation
import UIKit

extension MainViewController {
    
    func titleViewSetting(presentImage: String, presentText: String, presentTmp: String, maxTmp: String, minTmp: String, fellTmp: String) -> UIView {
        
        let titleInImageView: UIImageView = {
            let imageView = UIImageView()
            
            imageView.image = UIImage(systemName: presentImage)
            imageView.backgroundColor = .white
            
            return imageView
        }()
        
        let titleInWeatherTextLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = .white
            label.text = presentText
            
            return label
        }()
        
        let titleInTempNum: UILabel = {
            let label = UILabel()
            label.backgroundColor = .magenta
            label.textAlignment = .center
            label.font = label.font.withSize(40)
            label.text = presentTmp + "˚"
            
            return label
        }()
        
        let titleInmaxTempStackView = CustomTempStackView().tempSetting(tempName: "최고", tempNameColor: .red, temp: maxTmp + "˚")
        let titleInminTempStackView = CustomTempStackView().tempSetting(tempName: "최저", tempNameColor: .blue, temp: minTmp + "˚")
        
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
        
        let titleInBottomStackView = CustomTempStackView().tempSetting(tempName: "체감온도", tempNameColor: .white, temp: fellTmp)
        
        let titleView: UIView = {
            let view = UIView()
            
            view.backgroundColor = .systemCyan
            view.addSubview(titleInImageView)
            view.addSubview(titleInWeatherTextLabel)
            view.addSubview(titleInTopTempStackView)
            view.addSubview(titleInBottomStackView)
            
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
            make.centerX.equalTo(titleInTopTempStackView.snp.centerX)
        }
        
        return titleView
    }
}
