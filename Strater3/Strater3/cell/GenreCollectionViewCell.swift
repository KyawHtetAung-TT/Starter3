//
//  GenreCollectionViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/30.
//

import UIKit
import Foundation

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var viewForOverlay: UIView!
    
    var onTapItem : ((Int) -> Void) = { _ in}
    
    var data: GenreVO?=nil{
        
        didSet{
           
            if let genre = data{
                lblGenre.text = genre.name.uppercased()
                (genre.isSelected) ? (viewForOverlay.isHidden = false) : (viewForOverlay.isHidden = true)
                (genre.isSelected) ? (lblGenre.textColor = UIColor(named: "White")) : (lblGenre.textColor = .gray)

            }
            
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGestureForContainer = UITapGestureRecognizer(target: self, action: #selector(didTapItem))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tapGestureForContainer)
    }
    @objc func didTapItem(){
        
        onTapItem(data?.id ?? 0)
    }
    
    func genreColor(){
        
        if let genre = data{
            lblGenre.text = genre.name
            (genre.isSelected) ? (lblGenre.textColor = UIColor(named: "White")) : (lblGenre.textColor = .gray)
        }
    }
}

