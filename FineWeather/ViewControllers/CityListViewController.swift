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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("deleteVC"), object: nil)
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
    
    // 옆으로 슬라이드하여 도시 삭제 함수
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if indexPath.row != 0 {
                AddedCityDatas.shared.cityDatas.remove(at: indexPath.row)
                cityListTableView.deleteRows(at: [indexPath], with: .fade)
                
                NotificationCenter.default.post(name: NSNotification.Name("deleteVC"), object: indexPath.row)
            } else {
                let alert = UIAlertController(title: "현재 위치", message: "현재 위치는 삭제할 수 없습니다", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                present(alert, animated: true)
            }
        }
    }
    
   
    
    
}
