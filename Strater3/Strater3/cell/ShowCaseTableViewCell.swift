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
        showCaseCollectionView.dataSource = self
        showCaseCollectionView.delegate = self
        
        showCaseCollectionView.register(UINib(nibName: String(describing: ShowCaseCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ShowCaseCollectionViewCell.self))
        lblMoreShowCase.underlineText(text: "MORE SHOWCASES")
        
        showCaseCollectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ShowCaseTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShowCaseCollectionViewCell.self), for: indexPath) as? ShowCaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-100, height: 200
         )
        
    }

    
}
