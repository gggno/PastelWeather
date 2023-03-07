//
//  PlusViewController.swift
//  PastelWeather
//
//  Created by 정근호 on 2022/12/19.
//

import UIKit
import SnapKit
import MapKit
import RealmSwift

class PlusViewController: UIViewController {
    
    let realm = try! Realm()
    let localDB = LocalDB()
    
    var searchCompleter = MKLocalSearchCompleter() // 검색을 도와주는 변수
    var searchRequest = MKLocalSearch.Request()
    var searchResults = [MKLocalSearchCompletion]() // 검색 결과를 담는 변수
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.keyboardAppearance = .dark
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.leftView?.tintColor = UIColor.white.withAlphaComponent(0.5)
        searchBar.searchTextField.backgroundColor = .lightGray
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.font = .systemFont(ofSize: 14, weight: .semibold)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색",
                                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)])
        return searchBar
    }()
    
    let cancelBtn: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(touchupCancelBtn(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let topView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    let searchTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlusViewController - viewDidLoad() called")
        
        self.navigationController?.navigationBar.tintColor = .white

        searchBar.delegate = self
        
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchTableView.separatorStyle = .none
        
        self.view.backgroundColor = UIColor(named: "PlusVCColor")
        self.title = "관심지역"
        
        topView.addSubview(searchBar)
        topView.addSubview(cancelBtn)
        
        view.addSubview(topView)
        view.addSubview(searchTableView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(6)
            make.trailing.equalTo(cancelBtn.snp.leading).offset(-2)
            make.height.equalTo(40)
        }

        cancelBtn.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
        }

        topView.snp.makeConstraints { make in
            make.height.equalTo(searchBar.snp.height)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func convertSearchAddress(from coordinate:CLLocation, vc: UIViewController) {
        let geoCoder = CLGeocoder()
        let locale = Locale(identifier: "ko-kr")
        geoCoder.reverseGeocodeLocation(coordinate, preferredLocale: locale) { (placemarks, error) in
            if let someError = error {
                print("PlusViewController - convertSearchAddress Error:", someError)
                return
            }
            guard let placemark = placemarks?.first else { return }
            
            let state = placemark.administrativeArea ?? ""
            let subState = placemark.subAdministrativeArea ?? ""
            let city = placemark.locality ?? ""
            
            if subState == "" {
                if state == city {
                    // 처음 도시 추가했을때 도시이름 표시
                    vc.title = state
                    
                    // 로컬 DB에 도시이름 저장
                    try! self.realm.write{
                        self.realm.add(self.localDB)
                        self.localDB.cityName = state
                    }
                } else {
                    // 처음 도시 추가했을때 도시이름 표시
                    vc.title = "\(state) \(city)"
                    
                    // 로컬 DB에 도시이름 저장
                    try! self.realm.write{
                        self.realm.add(self.localDB)
                        self.localDB.cityName = "\(state) \(city)"
                    }
                }
            } else {
                // 처음 도시 추가했을때 도시이름 표시
                vc.title = "\(state) \(subState)"
                
                // 로컬 DB에 도시이름 저장
                try! self.realm.write{
                    self.realm.add(self.localDB)
                    self.localDB.cityName = "\(state) \(subState)"
                }
            }
        }
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "관심지역 추가", message: "관심지역이 추가되었습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
//        self.searchBar.text = nil
        present(alert, animated: true)
    }
    
    @objc func touchupCancelBtn(_ sender: UIButton) {
        print("PlusViewController - touchupCancelBtn() called")
        view.endEditing(true)
    }

}
