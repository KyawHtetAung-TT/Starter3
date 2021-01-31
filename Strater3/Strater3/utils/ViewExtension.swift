//
//  ViewExtension.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/31.
//

import Foundation
import UIKit

extension UILabel{
    
    func underlineText(text:String){
        
        let attributeString = NSMutableAttributedString.init(string: text)
        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 3, range: NSRange(location: 0, length: attributeString.length))
        self.attributedText = attributeString
        
        
    }
    
    
}
