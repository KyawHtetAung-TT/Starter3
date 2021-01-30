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
    
    var onTapItem : ((String) -> Void) = { _ in}
    
    var data: GenreVO?=nil{
        
        didSet{
           
            if let genre = data{
                lblGenre.text = genre.name
                (genre.isSelected) ? (viewForOverlay.isHidden = false) : (viewForOverlay.isHidden = true)
                genreColor()

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
        
        onTapItem(data?.name ?? "")
    }
    
    func genreColor(){
        
        if let genre = data{
            lblGenre.text = genre.name
            (genre.isSelected) ? (lblGenre.textColor = .white) : (lblGenre.textColor = .darkGray)
        }
    }
}

