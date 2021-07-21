//
//  SearchContentViewController.swift
//  Strater3
//
//  Created by Ryan Willson on 7/15/21.
//

import UIKit

class SearchContentViewController: UIViewController {

//    @IBOutlet weak var ivBack: UIImageView!
//    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var collectionViewResults: UICollectionView!
    
    private var searchBar = UISearchBar()
    
    private var searchedResult : [MovieResult] = []
    
    private let itemSpacing : CGFloat = 10
    private let numberOfItemPerRow = 3
    private var currentPage : Int = 1
    private var totalPage : Int = 1
    
    
    private let networkAgent = MovieDBNetworkAgent.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        initView()
        
    }

    private func initView(){
        
//        textFieldSearch.backgroundColor = UIColor(named: "Color primary")
//        textFieldSearch.attributedPlaceholder = NSAttributedString.init(
//            string: "Search...",
//            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
//        textFieldSearch.font = UIFont.systemFont(ofSize: 16)
//        textFieldSearch.delegate = self
        
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .white
        
        navigationItem.titleView = searchBar
        
        setupCollectionView()
    }
  
    func setupCollectionView(){
        collectionViewResults.delegate = self
        collectionViewResults.dataSource = self
        collectionViewResults.showsHorizontalScrollIndicator = false
        collectionViewResults.showsVerticalScrollIndicator = false
        collectionViewResults.contentInset = UIEdgeInsets.init(top: 20, left: 16, bottom: 16, right: 16)
        if let layout = collectionViewResults.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .vertical
        
            collectionViewResults.register(UINib(nibName: String(describing: PopularFilmCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self))
        }
    
    }

    func textFieldShouldRetrun(_ textField : UITextField)-> Bool{
        self.view.endEditing(true)
        
        if let data = textField.text{
            self.currentPage = 1
            self.totalPage = 1
            self.searchedResult.removeAll()
            searchContent(keyword : data,page: currentPage)
        }
        return false
    }
    
    func searchContent(keyword : String, page : Int){
        
        // TODO :
        
    }
    
}

extension SearchContentViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self), for: indexPath) as? PopularFilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = searchedResult[indexPath.row]
//        cell.onTapItem = { id in
//            self.nevigateToMovieDetailViewController(movieId: id)
//        }
        
        return cell
    }
    
    
}
extension  SearchContentViewController : UICollectionViewDelegateFlowLayout{

    // -> TODO:
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let totatColumnSpacing : CGFloat = (itemSpacing * CGFloat(numberOfItemPerRow - 1)) + (collectionView.contentInset.left + collectionView.contentInset.right)

        let itemWidth : CGFloat = (collectionView.frame.width / CGFloat(numberOfItemPerRow)) - (totatColumnSpacing / CGFloat(numberOfItemPerRow))

        let itemHeight : CGFloat = (itemWidth * 1.5) + 80 // for text and rating
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let isAtlastRow = indexPath.row == self.searchedResult.count - 1
        let hasMorePage = self.currentPage < self.totalPage

        if (isAtlastRow && hasMorePage) {
            currentPage = currentPage + 1
            searchContent(keyword: searchBar.text ?? "", page: currentPage)
            
        }
    }


}

extension SearchContentViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        searchBar.endEditing(true)
        if let data = searchBar.text{
            self.currentPage = 1
            self.totalPage = 1
            self.searchedResult.removeAll()
            searchContent(keyword : data,page: currentPage)
        }
    }
    
}








