//
//  ShowCaseTableViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/31.
//

import UIKit

class ShowCaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblShowCase: UILabel!
    @IBOutlet weak var lblMoreShowCase: UILabel!
    @IBOutlet weak var showCaseCollectionView: UICollectionView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
