//
//  CustomDayStackView.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/23.
//

import Foundation
import UIKit

class CustomDayStackView: UIStackView {
    
    let dayInTimeLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dayInImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let dayInTmpLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    func dayStackViewSetting(time: String, image: String, tmp: String ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [dayInTimeLabel, dayInImageView, dayInTmpLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        dayInTimeLabel.text = time
        dayInImageView.image = UIImage(systemName: image)
        dayInTmpLabel.text = tmp + "˚"
        
        return stackView
    }
    
    
}
