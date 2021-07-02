//
//  PopularFilmCollectionViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/29.
//

import UIKit

class PopularFilmCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelContentTitle : UILabel!
    @IBOutlet weak var imageViewBackdrop : UIImageView!
    @IBOutlet weak var ratingStar : RatingControl!
    @IBOutlet weak var labelRating : UILabel!
    
    
    var data : MovieResult?{
        didSet {
            if let data = data {
                let title = data.originalTitle ?? data.originalName 
                let backdropPath = "\(AppConstants.baseImageUrl)/\(data.backdropPath ?? "")"
                
                labelContentTitle.text = title
                imageViewBackdrop.sd_setImage(with: URL(string: backdropPath))
                let voteAverage = data.voteAverage ?? 0.0
                labelRating.text = "\(voteAverage)" // max - 10
                ratingStar.starCount =  Int(voteAverage * 0.5) // max - 5
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
