//
//  GenreSmallollectionViewCell.swift
//  Strater3
//
//  Created by Ryan Willson on 6/5/21.
//

import UIKit

class GenreSmallCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblGenre: UILabel!
    
//    let movieGenre : String = ["adventure","action","family"]
    let quoteArray : [String] = ["Family", "Fantasy","Adventure","Action","Drama"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.lblGenre.text = quoteArray[Int(arc4random_uniform(UInt32(quoteArray.count)))]
//        lblGenre.text = RandomNumberGenerator(movieGenre[IndexPath])
        
    }

}
