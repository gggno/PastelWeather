//
//  CityListViewController.swift
//  PastelWeather
//
//  Created by 정근호 on 2023/02/21.
//

import UIKit
import SnapKit
import RealmSwift

class CityListViewController: UIViewController {
    
    let realm = try! Realm()
    let localDB = LocalDB()
    
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
        //        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "PlusVCColor")
        
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
        let dbDatas = realm.objects(LocalDB.self)
        
        return dbDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cityListTableView.dequeueReusableCell(withIdentifier: "AddedCitiesTableViewCell", for: indexPath) as? AddedCitiesTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        
        let dbDatas = realm.objects(LocalDB.self)
        
        cell.cityLabel.text = dbDatas[indexPath.row].cityName
        
        return cell
    }
    
    // 옆으로 슬라이드하여 도시 삭제 함수
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dbDatas = realm.objects(LocalDB.self)
            
            // 현재위치는 삭제 안되게
            if dbDatas[0].currentVCConfirm == true && indexPath.row == 0 { // 첫번째 row가 현재위치면 삭제불가
                let alert = UIAlertController(title: "현재 위치", message: "현재 위치는 삭제할 수 없습니다", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                present(alert, animated: true)
            } else {
                
                try! realm.write{
                    realm.delete(dbDatas[indexPath.row])
                    print("로컬 DB 데이터 삭제")
                }
                
                cityListTableView.deleteRows(at: [indexPath], with: .fade)
                
                NotificationCenter.default.post(name: NSNotification.Name("deleteVC"), object: indexPath.row)
            }
        }
    }
    
}
