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
        
        
        return label
    }()
    
    
    let tempLabel: UILabel = {
        let label = UILabel()
        
        
        return label
    }()
    
    func tempSetting(tempName: String, temp: String) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [tempNameLabel, tempLabel])
        
        tempNameLabel.text = tempName + ":"
        tempLabel.text = temp
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }
    
}
