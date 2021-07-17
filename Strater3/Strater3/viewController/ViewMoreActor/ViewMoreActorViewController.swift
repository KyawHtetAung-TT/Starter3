//
//  ViewMoreActorViewController.swift
//  Strater3
//
//  Created by Ryan Willson on 7/14/21.
//

import UIKit

class ViewMoreActorViewController: UIViewController {

    @IBOutlet weak var collectionViewActors : UICollectionView!

    var initData : ActorListResponse?

    private var data : [ActorInfoResopnse] = []
    
    private let networkAgent = MovieDBNetworkAgent.shared
    
    private let itemSpacing : CGFloat = 10
    private let numberOfItemsPerRow = 3
    private var totalPages : Int = 1
    private var currentPage : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initState()
        
    }

    private func initView(){
        setupCollectionView()
    }

    private func initState(){
        currentPage = initData?.page ?? 1
        totalPages = initData?.totalPages ?? 1
        
        data.append(contentsOf: initData?.results ?? [ActorInfoResopnse]())
        collectionViewActors.reloadData()
    }

    
    private func fetchData(page : Int){
        networkAgent.getPopularPeople (page : page){ (data) in
            self.data.append(contentsOf: data.results ?? [ActorInfoResopnse]())
            self.collectionViewActors.reloadData()
        } failure: { (error) in
            print(error)
        }


    }
    
    func setupCollectionView(){
        
        collectionViewActors.dataSource = self
        collectionViewActors.delegate = self
        collectionViewActors.showsHorizontalScrollIndicator = false
        collectionViewActors.showsVerticalScrollIndicator = false
        collectionViewActors.contentInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 161, right: 16)
        if let layout = collectionViewActors.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .vertical
        }
       
        collectionViewActors.register(UINib(nibName: String(describing: BestActorCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BestActorCollectionViewCell.self))
    }

    

}

extension ViewMoreActorViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
//        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath) as? BestActorCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        cell.data = data[indexPath.row]
        return cell
    }
    
  
    
}
extension  ViewMoreActorViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let totatSacing : CGFloat = (itemSpacing * CGFloat(numberOfItemsPerRow - 1)) + (collectionView.contentInset.left + collectionView.contentInset.right)

        let itemWidth : CGFloat = (collectionView.frame.width / CGFloat(numberOfItemsPerRow)) - (totatSacing / CGFloat(numberOfItemsPerRow))

        let itemHeight : CGFloat = itemWidth * 1.5

        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let isAtlastRow = indexPath.row == (data.count - 1)
        let hasMorePage = currentPage < totalPages // 9, 10 => page 10 => fetchData(page_ 10)

        if isAtlastRow && hasMorePage {
            currentPage = currentPage + 1

            // api call
            fetchData(page: currentPage)


        }
    }

}
