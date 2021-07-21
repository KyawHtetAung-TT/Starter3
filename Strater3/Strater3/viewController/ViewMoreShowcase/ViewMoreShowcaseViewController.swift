//
//  ViewMoreShowcaseViewController.swift
//  Strater3
//
//  Created by Ryan Willson on 7/15/21.
//

import UIKit




class ViewMoreShowcaseViewController: UIViewController {
    
    @IBOutlet weak var collectionViewMoreShowcase: UICollectionView!
    
    
//    private var data = [MovieResult]()
    private var data : [MovieResult] = []
//    private var moreShowCaseMovieList : MovieListResponse?
//
////    private var data : [MovieResult] = []
//    var  data : MovieResult? {
//        didSet{
//            if let _ = data{
//                collectionViewMoreShowcase.reloadData()
//            }
//        }
//    }
    
    private let networkAgent = MovieDBNetworkAgent.shared
    
    private let itemSpacing : CGFloat = 10
    private let numberOfItemsPerRow = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        fetchData()
        // Do any additional setup after loading the view.
        self.title = String("More Showcase")
    }

    private func initView(){
        setupCollectionView()
    }
    
    private func fetchData(){
        networkAgent.getMoreShowCaseMovieList (){ (data) in
            
            self.data.append(contentsOf: data.results ?? [MovieResult]())
            self.collectionViewMoreShowcase.reloadData()
            
            
        } failure: { (error) in
            print(error)
        }


    }

    
    
    func setupCollectionView(){
        collectionViewMoreShowcase.delegate = self
        collectionViewMoreShowcase.dataSource = self
        collectionViewMoreShowcase.showsHorizontalScrollIndicator = false
        collectionViewMoreShowcase.showsVerticalScrollIndicator = false
        collectionViewMoreShowcase.contentInset = UIEdgeInsets.init(top: 20, left: 16, bottom: 16, right: 16)
        
        
        collectionViewMoreShowcase.register(UINib(nibName: String(describing: ShowCaseCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ShowCaseCollectionViewCell.self))
    }


}
extension ViewMoreShowcaseViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

//        return data?.results?.count ?? 0
            return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShowCaseCollectionViewCell.self), for: indexPath) as? ShowCaseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = data[indexPath.row]
        return cell
    }
    
    
    
}
extension  ViewMoreShowcaseViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemWidth : CGFloat = collectionView.frame.width - 50
        let itemHeight : CGFloat = (itemWidth/16)*9
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }

    
    

}
