//
//  BestActorTableViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/02/03.
//

import UIKit

class BestActorTableViewCell: UITableViewCell,ActorActionDelegate{
    

    @IBOutlet weak var lblBestActors: UILabel!
    @IBOutlet weak var lblMoreActors: UILabel!
    @IBOutlet weak var collectionViewActors: UICollectionView!
    
    var  data : ActorListResponse? {
        didSet{
            if let _ = data{
                collectionViewActors.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewActors.dataSource = self
        collectionViewActors.delegate = self
        
        collectionViewActors.registerForCell(identifier: BestActorCollectionViewCell.identifier)
        lblMoreActors.underlineText(text: "MORE ACOTRS")
    }
    
    func onTapFavourite(isFavourite: Bool) {
        debugPrint("isFavourite => \(isFavourite)")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension BestActorTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath) as? BestActorCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        let cell = collectionView.dequeCell(identifier: BestActorCollectionViewCell.identifier, indexPath:  indexPath)
        
        cell.delegate = self
        cell.data = data?.results?[indexPath.row]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth : CGFloat = 120
        let itemHeght : CGFloat = itemWidth * 1.5
        return CGSize(width: itemWidth, height: itemHeght)
        
//      return CGSize(width: collectionView.frame.width/3, height: CGFloat(220))
    }
    
    
    
}
