//
//  PopularFilmTableViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/29.
//

import UIKit

class PopularFilmTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewMoive: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewMoive.dataSource = self
        collectionViewMoive.delegate = self
        collectionViewMoive.register(UINib(nibName: String(describing: PopularFilmCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PopularFilmTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self), for: indexPath) as? PopularFilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: 270)
    }
    
    
    
}
