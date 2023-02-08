//
//  SearchTVC.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/07.
//

import Foundation
import UIKit
import SnapKit

class SearchTVC: UITableViewCell {
    static let identifier = "SearchTVC"
    // MARK: - Properties
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        
        label.font = label.font.withSize(14)
        label.textColor = .lightGray
        
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setupAutoLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = .init(white: 1.0, alpha: 0.1)
        } else {
            self.backgroundColor = .none
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    func configUI() {
    }
    
    func setupAutoLayout() {
        addSubview(countryLabel)
        
        countryLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(45)
        }
    }
}
