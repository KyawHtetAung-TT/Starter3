//
//  PopularFilmTableViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/29.
//

import UIKit

class PopularFilmTableViewCell: UITableViewCell {

    @IBOutlet weak var lableTitle: UILabel!
    @IBOutlet weak var collectionViewMoive: UICollectionView!
    
    var delegate:MovieItemDelegate? = nil
    
    
    var  data : MovieListResponse? {
        didSet{
            if let data = data{
                collectionViewMoive.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewMoive.dataSource = self
        collectionViewMoive.delegate = self
        
        collectionViewMoive.registerForCell(identifier: PopularFilmCollectionViewCell.identifier)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PopularFilmTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self), for: indexPath) as? PopularFilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.data = data?.results?[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data?.results?[indexPath.row]
        delegate?.onTapMovie(id: item?.id ?? -1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = 120
        let itemHeight : CGFloat = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    
    
}
