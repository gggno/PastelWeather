//
//  UIView+PreView.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/05.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    
    struct ViewRepresentable : UIViewRepresentable {
        let uiView : UIView
        
        func updateUIView(_ uiView: UIViewType, context: Context) { }
        
        func makeUIView(context: Context) -> some UIView {
            return uiView
        }
    }
    
    func getRepresentable() -> ViewRepresentable {
        return ViewRepresentable(uiView: self)
    }
}
