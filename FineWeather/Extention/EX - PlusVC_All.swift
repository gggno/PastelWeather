//
//  EX - PlusVC_All.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/08.
//

import Foundation
import UIKit
import MapKit

extension PlusViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchReqeust = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchReqeust)
        
        search.start { response, error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            
            
            
        }
        
    }
}

extension PlusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
       return cell
    }
}

extension PlusViewController: UISearchBarDelegate {
    
    // 검색창의 text가 변하는 경우 searchBar가 델리게이트로 알려주는 함수
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}

extension PlusViewController: MKLocalSearchCompleterDelegate {
    
    // 자동완성 완료 시에 결과를 받는 함수
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
