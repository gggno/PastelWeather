//
//  EX - MainVC_CLLocationManagerDelegate.swift
//  FineWeather
//
//  Created by 정근호 on 2023/01/09.
//

import Foundation
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let lat = location.coordinate.latitude // 위도
            let lon = location.coordinate.longitude // 경도
            print("위도: \(lat), 경도: \(lon)")
            let nx = Int(convertGrid(code: "toXY", v1: lat, v2: lon)["nx"]!)
            let ny = Int(convertGrid(code: "toXY", v1: lat, v2: lon)["ny"]!)
            print("nx: \(nx) ny: \(ny)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("MainViewController - locationManagerError: \(error)")
    }
    
    func convertGrid(code: String, v1: Double, v2: Double) -> [String: Double] {
        // LCC DFS 좌표변환을 위한 기초 자료
        let RE = 6371.00877 // 지구 반경(km)
        let GRID = 5.0 // 격자 간격(km)
        let SLAT1 = 30.0 // 투영 위도1(degree)
        let SLAT2 = 60.0 // 투영 위도2(degree)
        let OLON = 126.0 // 기준점 경도(degree)
        let OLAT = 38.0 // 기준점 위도(degree)
        let XO = 43 // 기준점 X좌표(GRID)
        let YO = 136 // 기1준점 Y좌표(GRID)
        //
        //
        // LCC DFS 좌표변환 ( code : "toXY"(위경도->좌표, v1:위도, v2:경도), "toLL"(좌표->위경도,v1:x, v2:y) )
        //
        let DEGRAD = Double.pi / 180.0
        let RADDEG = 180.0 / Double.pi
        
        let re = RE / GRID
        let slat1 = SLAT1 * DEGRAD
        let slat2 = SLAT2 * DEGRAD
        let olon = OLON * DEGRAD
        let olat = OLAT * DEGRAD
        
        var sn = tan(Double.pi * 0.25 + slat2 * 0.5) / tan(Double.pi * 0.25 + slat1 * 0.5)
        sn = log(cos(slat1) / cos(slat2)) / log(sn)
        var sf = tan(Double.pi * 0.25 + slat1 * 0.5)
        sf = pow(sf, sn) * cos(slat1) / sn
        var ro = tan(Double.pi * 0.25 + olat * 0.5)
        ro = re * sf / pow(ro, sn)
        var rs:[String:Double] = [:]
        var theta = v2 * DEGRAD - olon
        
        if (code == "toXY") {
            
            rs["lat"] = v1
            rs["lon"] = v2
            var ra = tan(Double.pi * 0.25 + (v1) * DEGRAD * 0.5)
            ra = re * sf / pow(ra, sn)
            if (theta > Double.pi) {
                theta -= 2.0 * Double.pi
            }
            if (theta < -Double.pi) {
                theta += 2.0 * Double.pi
            }
            theta *= sn
            rs["nx"] = floor(ra * sin(theta) + Double(XO) + 0.5)
            rs["ny"] = floor(ro - ra * cos(theta) + Double(YO) + 0.5)
        }
        else {
            rs["nx"] = v1
            rs["ny"] = v2
            let xn = v1 - Double(XO)
            let yn = ro - v2 + Double(YO)
            let ra = sqrt(xn * xn + yn * yn)
            if (sn < 0.0) {
                sn - ra
            }
            var alat = pow((re * sf / ra), (1.0 / sn))
            alat = 2.0 * atan(alat) - Double.pi * 0.5
            
            if (abs(xn) <= 0.0) {
                theta = 0.0
            }
            else {
                if (abs(yn) <= 0.0) {
                    let theta = Double.pi * 0.5
                    if (xn < 0.0){
                        xn - theta
                    }
                }
                else{
                    theta = atan2(xn, yn)
                }
            }
            let alon = theta / sn + olon
            rs["lat"] = alat * RADDEG
            rs["lng"] = alon * RADDEG
        }
        print("rs: \(rs)")
        print("rsNX: \(String(describing: rs["nx"]))")
        return rs
    }
    
    // 타이틀에 현재 위치 나타내기
    func convertCurrentAddress(from coordinate:CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(coordinate) { (placemarks, error) in
            if let someError = error {
                print("MainViewController - convertCurrentAddress Error:", someError)
                return
            }
            guard let placemark = placemarks?.first else { return }
            
            let state = placemark.administrativeArea ?? ""
            let subState = placemark.subAdministrativeArea ?? ""
            let city = placemark.locality ?? ""
            
            let dbDatas = self.realm.objects(LocalDB.self)
            
            if subState == "" {
                if state == city {
                    self.title = state
                    AddedCityDatas.shared.cityNameDatas.append(state)
                    try! self.realm.write{
                        dbDatas[0].cityName = state
                    }
                } else {
                    self.title = "\(state) \(city)"
                    AddedCityDatas.shared.cityNameDatas.append("\(state) \(city)")
                    try! self.realm.write{
                        dbDatas[0].cityName = "\(state) \(city)"
                    }
                }
            } else {
                self.title = "\(state) \(subState)"
                AddedCityDatas.shared.cityNameDatas.append("\(state) \(subState)")
                try! self.realm.write{
                    dbDatas[0].cityName = "\(state) \(subState)"
                }
            }
        }
    }
    
}
