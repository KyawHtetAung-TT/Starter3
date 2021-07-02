//
//  MovieSliderTableViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/28.
//

import UIKit


class MovieSliderTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewMovie: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var delegate:MovieItemDelegate? = nil
    
    var  data : MovieListResponse? {
        didSet{
            if let data = data{
                pageControl.numberOfPages = data.results?.count ?? 0
                collectionViewMovie.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewMovie.dataSource = self
        collectionViewMovie.delegate = self
        
//        collectionViewMovie.register(UINib(nibName:String(describing: MovieSliderCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieSliderCollectionViewCell.self))
        
        collectionViewMovie.registerForCell(identifier: MovieSliderCollectionViewCell.identifier)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MovieSliderTableViewCell:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results?.count ?? 0
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieSliderCollectionViewCell.self), for: indexPath) as? MovieSliderCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let cellData = data?.results?[indexPath.row]
        cell.data = cellData
        return cell
        
        
        
        
//        let cell = collectionView.dequeCell(identifier: MovieSliderCollectionViewCell.identifier, indexPath: indexPath)
//            return cell
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onTapMovie()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = 120
        let itemHeight : CGFloat = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
      
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
    }
    
    
    
}
