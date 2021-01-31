//
//  MovieShowTImeTableViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/30.
//

import UIKit

class MovieShowTImeTableViewCell: UITableViewCell {
    @IBOutlet weak var viewForBackgruoud: UIView!
    
    @IBOutlet weak var lblSeeMore: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewForBackgruoud.layer.cornerRadius = 4
        
//        viewForBackgruoud.layer.cornerRadius = 20
//        viewForBackgruoud.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMinYCorner]
        
//      let attributeString = NSMutableAttributedString(string: "SEE MORE")
//        attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: 3, range: NSRange(location: 0, length: attributeString.length))
//        lvlSeeMore.attributedText = attributeString
        
        lblSeeMore.underlineText(text: "SEE MORE")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
