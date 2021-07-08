//
//  BestActorCollectionViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/02/03.
//

import UIKit

class BestActorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivHeartFill: UIImageView!
    @IBOutlet weak var ivHeart: UIImageView!
    @IBOutlet weak var imageViewActorProfile : UIImageView!
    @IBOutlet weak var labelActorName : UILabel!
    @IBOutlet weak var labelKnownForDepartment : UILabel!
    
    
    var delegate : ActorActionDelegate?=nil
    
    var data : ActorInfoResopnse? {
        didSet{
            if let data = data{
                let posterPath = "\(AppConstants.baseImageUrl)\(data.profilePath ?? "")"
                imageViewActorProfile.sd_setImage(with: URL(string: posterPath), completed: nil)
                labelActorName.text = data.name
                labelKnownForDepartment.text = data.knownForDepartment
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initGestureRecognizer()
    }

    
      func initGestureRecognizer(){
        
        let tapGestureForFavourite = UITapGestureRecognizer(target: self, action: #selector(onTapFavourite))
        ivHeartFill.addGestureRecognizer(tapGestureForFavourite)
        ivHeartFill.isUserInteractionEnabled = true
        
        let tapGestureForUnfavourite = UITapGestureRecognizer(target: self, action: #selector(onTapUnfavourite))
        ivHeart.addGestureRecognizer(tapGestureForUnfavourite)
        ivHeart.isUserInteractionEnabled = true
        
    }
    
    @objc func onTapFavourite(){
        ivHeartFill.isHidden = true
        ivHeart.isHidden = false
        delegate?.onTapFavourite(isFavourite: true)
        
    }
    @objc func onTapUnfavourite(){
        ivHeartFill.isHidden = false
        ivHeart.isHidden = true
        delegate?.onTapFavourite(isFavourite: false)
        
    }
}
