//
//  CustomView.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/04.
//

import Foundation
import UIKit
import SnapKit

class CustomView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        
        return progress
    }()
    
    lazy var fromInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "환경부 한국환경공단"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupLayout(title: String, value: String, grade: String) {
        titleLabel.text = title
    }
}
