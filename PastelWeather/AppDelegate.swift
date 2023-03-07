//
//  AppDelegate.swift
//  FineWeather
//
//  Created by 정근호 on 2022/12/14.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setNotification()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // 앱 추적 허용 알림창
    func setNotification(){
        let n = NotificationHandler()
        n.askNotificationPermission {
            // 다른 권한 요청 창보다 늦게 띄우기
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if #available(iOS 14, *) {
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                        switch status {
                        case .authorized:        // 허용됨
                            print("Authorized")
                            print("IDFA = \(ASIdentifierManager.shared().advertisingIdentifier)")    // IDFA 접근
                        case .denied:        // 거부됨
                            print("Denied")
                        case .notDetermined:    // 결정되지 않음
                            print("Not Determined")
                        case .restricted:        // 제한됨
                            print("Restricted")
                        @unknown default:        // 알려지지 않음
                            print("Unknown")
                        }
                    })
                } else { // ios 14 이전 버전은 권한 요청이 필요하지 않으므로 권한 요청 없이 진행
                    let idfa = ASIdentifierManager.shared().advertisingIdentifier
                    
                }
            }
        }
    }
    
}

