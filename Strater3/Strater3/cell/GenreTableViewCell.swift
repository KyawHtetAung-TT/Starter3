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
    
    let genreList = [GenreVO(name: "ACTION", isSelected: true),GenreVO(name: "ADVENTURE", isSelected: false),GenreVO(name: "CRIMINAL", isSelected: false),GenreVO(name: "DRAMA", isSelected: false),GenreVO(name: "COMEDY", isSelected: false)]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewGenre.dataSource = self
        collectionViewGenre.delegate = self
        collectionViewGenre.register(UINib(nibName: String(describing: GenreCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: GenreCollectionViewCell.self))
        
        
        collectionViewMovie.dataSource = self
        collectionViewMovie.delegate = self
        collectionViewMovie.register(UINib(nibName: String(describing: PopularFilmCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension GenreTableViewCell : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionViewMovie{
            return 10
        }
        return genreList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewMovie{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self), for: indexPath) as? PopularFilmCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        }else{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenreCollectionViewCell.self), for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = genreList[indexPath.row]
        
        cell.onTapItem = { genreName in
            self.genreList.forEach { (genreVO) in
                if genreName == genreVO.name{
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
         
            return CGSize(width: collectionView.frame.width/3, height: 240)
        }
        
        return CGSize(width: widthOfString(text: genreList[indexPath.row].name,font: UIFont(name: "Geeza Pro Regular", size: 14) ?? UIFont.systemFont(ofSize: 14))+40, height: 40)
    }
    
    func widthOfString(text : String,font : UIFont)-> CGFloat{
    
        let fontAttribute = [NSAttributedString.Key.font : font]
        let textSize = text.size(withAttributes: fontAttribute)
        
        return textSize.width
    }
    
    
    
}