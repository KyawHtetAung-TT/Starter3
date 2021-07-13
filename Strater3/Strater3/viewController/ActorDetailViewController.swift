//
//  ActorDetailViewController.swift
//  Strater3
//
//  Created by Ryan Willson on 7/13/21.
//

import UIKit


class ActorDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let networkAgent = MovieDBNetworkAgent.shared
    
    @IBOutlet weak var ivActorDetailBack: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDateOfBirth: UILabel!
    @IBOutlet weak var lblActorName: UILabel!
    @IBOutlet weak var lblBiographyDetail: UILabel!
    
    @IBOutlet weak var collectionViewTVCredit: UICollectionView!
    
    
    private var actorDetail : [ActorDetailResponse] = []
    
    var actorID : Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actorDetailnib()
        initGestureRecognizerBack()
        
        getActorCreditById(id: actorID)
        
        
        
        // see more
        lblBiographyDetail.numberOfLines = 5
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.labelAction(gesture:)))
        lblBiographyDetail.addGestureRecognizer(tap)
        lblBiographyDetail.isUserInteractionEnabled = true
                tap.delegate = self

        
    }

    
    
    // actor detail response
    
    
    private func getActorCreditById(id : Int){
        networkAgent.getActorDetailById(id: id) { (data) in
            //actor detail
            self.binddata(data: data)
//            self.casts = data.cast ?? [MovieCast]()
//            self.collectionViewActor.reloadData()
        } failure: { (error) in
            print(error)
        }

    }
    
    private func binddata(data : ActorDetailResponse){
        
        let posterPath = "\(AppConstants.baseImageUrl)\(data.profilePath ?? "")"
        imgView.sd_setImage(with: URL(string: posterPath))
        
        lblDateOfBirth.text = data.birthday
        lblActorName.text = data.name
        lblBiographyDetail.text = data.biography
        
    
    }
    
    
        
    // See more
    @objc func labelAction(gesture: UITapGestureRecognizer){
           if lblBiographyDetail.numberOfLines == 0 {
            lblBiographyDetail.numberOfLines = 5
           } else {
            lblBiographyDetail.numberOfLines = 0
           }
    }
    
    
    
    private func actorDetailnib(){
        collectionViewTVCredit.delegate = self
        collectionViewTVCredit.dataSource = self
        collectionViewTVCredit.register(UINib(nibName: String(describing: PopularFilmCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self))
    }
    
    private func initGestureRecognizerBack(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapButton))
        ivActorDetailBack.isUserInteractionEnabled = true
        ivActorDetailBack.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func onTapButton(){
    
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
extension ActorDetailViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing : PopularFilmCollectionViewCell.self), for: indexPath) as? PopularFilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = 120
        let itemHeght : CGFloat = itemWidth * 1.5
        return CGSize(width: itemWidth, height: itemHeght)
    }
    
    
    
}


