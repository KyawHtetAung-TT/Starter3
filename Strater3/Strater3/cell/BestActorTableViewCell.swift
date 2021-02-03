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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewActors.dataSource = self
        collectionViewActors.delegate = self
        
        collectionViewActors.register(UINib(nibName: String(describing: BestActorCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BestActorCollectionViewCell.self))
        
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath) as? BestActorCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: CGFloat(220))
    }
    
    
    
}
