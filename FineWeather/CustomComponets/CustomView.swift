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
        
        label.font = label.font.withSize(25)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var currentStateLabel: UILabel = {
        let label = UILabel()
        
        label.font = label.font.withSize(20)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        
        return progress
    }()
    
    lazy var minValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = label.font.withSize(15)
        
        return label
    }()
    
    lazy var standardLabel: UILabel = {
        let label = UILabel()
        
        label.font = label.font.withSize(10)
        
        return label
    }()
    
    lazy var fromInfoLabel: UILabel = {
        let label = UILabel()
        
        label.text = "기준: 한국환경공단"
        label.font = label.font.withSize(10)
        label.textColor = .lightGray
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .orange
        self.addSubview(titleLabel)
        self.addSubview(currentStateLabel)
        self.addSubview(progressView)
        self.addSubview(minValueLabel)
        self.addSubview(standardLabel)
        self.addSubview(fromInfoLabel)
 
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
        }
        
        currentStateLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        progressView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        minValueLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(5)
            make.leading.equalTo(progressView.snp.leading)
        }
        
        standardLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalTo(progressView)
        }
        
        fromInfoLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupLayout(title: String, value: String, grade: String, minValue: String, currentState: String) {
        titleLabel.text = title
        minValueLabel.text = minValue
        currentStateLabel.text = currentState
    }
}

#if DEBUG

import SwiftUI

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView().getRepresentable()
            .frame(maxWidth: .infinity)
            .frame(height: 150)
    }
}

#endif
