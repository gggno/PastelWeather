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
        
        label.text = "타이틀"
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .cyan
        
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = .green
        progress.trackTintColor = .lightGray
        progress.setProgress(0.7, animated: true)
        return progress
    }()
    
    lazy var fromInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "환경부 한국환경공단"
        label.backgroundColor = .cyan
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
        self.addSubview(titleLabel)
        self.addSubview(progressView)
        self.addSubview(fromInfoLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        fromInfoLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupLayout(title: String, value: String, grade: String) {
        titleLabel.text = title
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
