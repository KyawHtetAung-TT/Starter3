//
//  ShowCaseTableViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/31.
//

import UIKit
import Foundation


class ShowCaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblShowCase: UILabel!
    @IBOutlet weak var lblMoreShowCase: UILabel!
    @IBOutlet weak var showCaseCollectionView: UICollectionView!
    @IBOutlet weak var heightCollectionViewShowCase : NSLayoutConstraint!
    
    var delegate : ShowcaseItemDelegate? = nil
    
    var  data : MovieListResponse? {
        didSet{
            if let _ = data{
                showCaseCollectionView.reloadData()
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showCaseCollectionView.dataSource = self
        showCaseCollectionView.delegate = self
        
        
        showCaseCollectionView.registerForCell(identifier: ShowCaseCollectionViewCell.identifier)
        
        lblMoreShowCase.underlineText(text: "MORE SHOWCASES")
        
//        showCaseCollectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        
        // cell ရဲ့  height နဲ့ collectionview ရဲ့ height ကိုချိန်တာတူအောင်လို
        let itemWidth : CGFloat = showCaseCollectionView.frame.width - 50
        let itemHeight : CGFloat = (itemWidth/16)*9
        heightCollectionViewShowCase.constant = itemHeight
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

extension ShowCaseTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return data?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(identifier: ShowCaseCollectionViewCell.identifier, indexPath: indexPath) as ShowCaseCollectionViewCell
        cell.data = data?.results?[indexPath.row]
        return cell
        
    }
    // 16/9 ration for aspect fit
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = collectionView.frame.width - 50
        let itemHeight : CGFloat = (itemWidth/16)*9
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ( (scrollView.subviews[(scrollView.subviews.count-1)]).subviews[0]).backgroundColor = UIColor(named: "Yellow")
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = data?.results?[indexPath.row]
        delegate?.onTapShowcase(id: item?.id ?? -1)
    }
    
}
