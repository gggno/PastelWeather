//
//  AddedCitiesTableViewCell.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/20.
//

import UIKit

class AddedCitiesTableViewCell: UITableViewCell {
    static let identifier = "AddedCitiesTableViewCell"
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        if selected {
//            self.backgroundColor = .init(white: 1.0, alpha: 0.1)
//        } else {
//            self.backgroundColor = .white
//        }
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupAutoLayout() {
        addSubview(cityLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
    }
}
