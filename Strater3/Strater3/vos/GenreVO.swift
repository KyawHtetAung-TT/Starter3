//
//  GenreVO.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/30.
//

import Foundation

class GenreVO{
    
    var id : Int = 0
    var name : String = "ACTION"
    var isSelected : Bool = false
    
    
    init(id:Int = 0,name : String,isSelected : Bool) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}
