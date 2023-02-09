//
//  EX - UILabel.swift
//  FineWeather
//
//  Created by 정근호 on 2023/02/09.
//

import Foundation
import UIKit

extension UILabel {
   func setHighlighted(_ text: String, with search: String) {
       let attributedText = NSMutableAttributedString(string: text)
       let range = NSString(string: text).range(of: search, options: .caseInsensitive)
       let highlightFont = UIFont.systemFont(ofSize: 16)
       let highlightColor = UIColor.white
       let highlightedAttributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.font: highlightFont, NSAttributedString.Key.foregroundColor: highlightColor]
       
       attributedText.addAttributes(highlightedAttributes, range: range)
       self.attributedText = attributedText
   }
}
