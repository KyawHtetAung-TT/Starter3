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

extension UITableViewCell{
    
    static var identifier : String{
        String(describing: self)
        
    }
}

extension UITableView{
    
    func registerForCell(identifier : String){
        
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeCell <T:UITableViewCell> (identifier : String,indexPath : IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
    
}


extension UICollectionViewCell{
    
    static var identifier : String{
        String(describing: self)
        
    }
}

extension UICollectionView{
    
    func registerForCell(identifier : String){
        
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeCell <T:UICollectionViewCell> (identifier : String,indexPath : IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return UICollectionViewCell() as! T
        }
        return cell
    }
    
}

extension UIViewController{
    static var identifier : String{
        String(describing: self)
    }
    
}



