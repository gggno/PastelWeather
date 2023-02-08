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
    
    private let searchCompleter = MKLocalSearchCompleter() // 검색을 도와주는 변수
    private var searchResults = [MKLocalSearchCompletion]() // 검색 결과를 담는 변수
    
    
    
    let searchTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .blue
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlusViewController - viewDidLoad() called")
        
        self.view.backgroundColor = .orange
        self.title = "관심지역"
        
        view.addSubview(searchTableView)
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
   
}
