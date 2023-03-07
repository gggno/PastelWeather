//
//  EX - MainVC_GADBannerViewDelegate.swift
//  FineWeather
//
//  Created by 정근호 on 2023/01/30.
//

import Foundation
import GoogleMobileAds

extension MainViewController: GADBannerViewDelegate {
    // 로드 완료
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
        addBannerViewToView(bannerView)
        bannerView.alpha = 0
          UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
          })
    }
    // 로드 실패
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    // 노출 직전
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }
    // 닫히기 직전
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }
    // 닫힌 순간
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }
    // 앱 백그라운드
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
    
}
