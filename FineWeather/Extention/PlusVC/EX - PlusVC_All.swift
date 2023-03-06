//
//  EX - PlusVC_All.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/08.
//

import Foundation
import UIKit
import MapKit

extension PlusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        print("cell: \(cell)")
        cell.countryLabel.text = searchResults[indexPath.row].title
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if let highlightText = searchBar.text {
            cell.countryLabel.setHighlighted(searchResults[indexPath.row].title, with: highlightText)
        }
        
        return cell
    }
}

extension PlusViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchReqeust = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchReqeust)
        
        let mainVC = MainViewController()
        
        search.start { response, error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let placeMark = response?.mapItems[0].placemark else {return}
            
            let searchLat = placeMark.coordinate.latitude
            let searchLon = placeMark.coordinate.longitude
            
            let searchLocation = CLLocation(latitude: searchLat, longitude: searchLon)
            self.convertSearchAddress(from: searchLocation, vc: mainVC)
            
            let xy = mainVC.convertGrid(code: "toXY", v1: searchLat, v2: searchLon)
            
            mainVC.lat = Int(xy["nx"] ?? 60) // 기본값은 서울특별시
            mainVC.lon = Int(xy["ny"] ?? 126) // 용산구
            mainVC.doubleLat = xy["lat"] ?? 60
            mainVC.doubleLon = xy["lon"] ?? 126
            
            // 로컬 DB에 도시 위도, 경도 값 저장
            self.localDB.lat = Int(xy["nx"] ?? 60)
            self.localDB.lon = Int(xy["ny"] ?? 126)
            self.localDB.doubleLat = xy["lat"] ?? 60
            self.localDB.doubleLon = xy["lon"] ?? 126
            
            try! self.realm.write {
                print("로컬 DB에 도시추가")
                self.realm.add(self.localDB)
            }
            
            print("plus lat, lon: \(mainVC.lat) \(mainVC.lon) double: \(mainVC.doubleLat) \(mainVC.doubleLon)")
            
            // 검색된 도시의 도시, 날씨정보를 페이지뷰에 전달
            NotificationCenter.default.post(name: NSNotification.Name("sendVC"), object: mainVC)
            
            self.presentAlert()
        }
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
        // 한국 지역만 나타나게 필터 적용
        searchResults.removeAll {!$0.title.contains("대한민국")}
        searchTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
