//
//  CityListViewController.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/21.
//

import UIKit
import SnapKit

class CityListViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
    
        label.text = "관심지역 목록"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let cityListTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        cityListTableView.delegate = self
        cityListTableView.dataSource = self
        cityListTableView.register(AddedCitiesTableViewCell.self, forCellReuseIdentifier: AddedCitiesTableViewCell.identifier)
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(cityListTableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        cityListTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    
    
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddedCityDatas.shared.cityDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cityListTableView.dequeueReusableCell(withIdentifier: "AddedCitiesTableViewCell", for: indexPath) as? AddedCitiesTableViewCell else {return UITableViewCell()}
        
        cell.cityLabel.text = AddedCityDatas.shared.cityDatas[indexPath.row]
        
        return cell
    }
    
    
    
}
