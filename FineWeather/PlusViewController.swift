//
//  PlusViewController.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/19.
//

import UIKit
import SnapKit
import MapKit

class PlusViewController: UIViewController {
    
    var searchCompleter = MKLocalSearchCompleter() // 검색을 도와주는 변수
    var searchResults = [MKLocalSearchCompletion]() // 검색 결과를 담는 변수
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
//        searchBar.becomeFirstResponder()
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
        
        searchBar.delegate = self
        
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchTableView.separatorStyle = .none
        
        self.view.backgroundColor = .orange
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
    
    @objc func touchupCancelBtn(_ sender: UIButton) {
        print("PlusViewController - touchupCancelBtn() called")
        self.dismiss(animated: true, completion: nil)
    }
    
}
