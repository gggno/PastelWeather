//
//  CustomTempView.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/22.
//

import Foundation
import UIKit

class CustomTempStackView: UIStackView {
    
    let tempNameLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .orange
        return label
    }()
    
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    func tempSetting(tempName: String, tempNameColor: UIColor, temp: String) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [tempNameLabel, tempLabel])
        
        tempNameLabel.text = tempName + ":"
        tempLabel.text = temp
        
        tempNameLabel.textColor = tempNameColor
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }
    
}
