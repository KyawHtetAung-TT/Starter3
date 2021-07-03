//
//  GenreTableViewCell.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/30.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewGenre: UICollectionView!
    @IBOutlet weak var collectionViewMovie: UICollectionView!
    
//    let genreList = [GenreVO(name: "ACTION", isSelected: true),GenreVO(name: "ADVENTURE", isSelected: false),GenreVO(name: "CRIMINAL", isSelected: false),GenreVO(name: "DRAMA", isSelected: false),GenreVO(name: "COMEDY", isSelected: false)]
    
    var genreList : [GenreVO]? {
        didSet{
            if let _ = genreList {
                collectionViewGenre.reloadData()
            }
        }
    }
    
    let movieList : [MovieResult] = []
    
    let movieListByGenre : [Int, ]
    
    /**
     let movieListKeyValuePair : [MovieGenreID : [MovieResult]]
     
     14 -> movieList
     12 -> movieList
     
     */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewGenre.dataSource = self
        collectionViewGenre.delegate = self
        collectionViewGenre.registerForCell(identifier: GenreCollectionViewCell.identifier)
        
        
        collectionViewMovie.dataSource = self
        collectionViewMovie.delegate = self
        collectionViewMovie.registerForCell(identifier: PopularFilmCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension GenreTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewMovie{
            return movieList.count
            
            
        }
        return genreList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewMovie{
         
//            let cell = collectionView.dequeCell(identifier: PopularFilmCollectionViewCell.identifier, indexPath: indexPath)
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self), for: indexPath) as? PopularFilmCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.data = movieList[indexPath.row]
            
            return cell
            
        }else{
            
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenreCollectionViewCell.self), for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
            
//        let cell = collectionView.dequeCell(identifier: GenreCollectionViewCell.identifier, indexPath:  indexPath)
            
        cell.data = genreList?[indexPath.row]
        
        cell.onTapItem = { genreId in
            self.genreList?.forEach { (genreVO) in
                if genreId == genreVO.id{
                    genreVO.isSelected = true
                }
                else{
                    genreVO.isSelected = false
                }
            }
            self.collectionViewGenre.reloadData()
        }
        
        return cell
        }
            
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionViewMovie{
         
            return CGSize(width: collectionView.frame.width/3, height: 250)
        }
        
        return CGSize(width: widthOfString(text: genreList?[indexPath.row].name ?? "",font: UIFont(name: "Geeza Pro Regular", size: 14) ?? UIFont.systemFont(ofSize: 14))+40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func widthOfString(text : String,font : UIFont)-> CGFloat{
    
        let fontAttribute = [NSAttributedString.Key.font : font]
        let textSize = text.size(withAttributes: fontAttribute)
        
        return textSize.width
    }
    
    
    
}
