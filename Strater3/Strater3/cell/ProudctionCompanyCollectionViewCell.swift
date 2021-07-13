//
//  ProudctionCompanyCollectionViewCell.swift
//  Strater3
//
//  Created by Ryan Willson on 7/9/21.
//

import UIKit

    
class ProudctionCompanyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewBackdrop : UIImageView!
    @IBOutlet weak var labelCompanyName : UILabel!
        
    
    var data : ProductionCompany?{
        didSet{
            if let data = data{
                let urlStr = "\(AppConstants.baseImageUrl)\(String(data.logoPath ?? ""))"
                imageViewBackdrop.sd_setImage(with: URL(string: urlStr))
                
                if data.logoPath == nil || data.logoPath!.isEmpty{
                    labelCompanyName.text = data.name
                }else{
                    labelCompanyName.text = ""
                }
              
            }
        }
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
    }

    
}
