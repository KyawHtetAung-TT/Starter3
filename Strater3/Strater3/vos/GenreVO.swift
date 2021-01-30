//
//  GenreVO.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/30.
//

import Foundation

class GenreVO{
    
    var name : String = "ACTION"
    var isSelected : Bool = false
    
    
    init(name : String,isSelected : Bool) {
        self.name = name
        self.isSelected = isSelected
    }
}
