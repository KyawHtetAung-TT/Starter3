//
//  MovieDetailViewController.swift
//  Strater3
//
//  Created by Ryan Willson on 6/3/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var ivBack: UIImageView!
    @IBOutlet weak var btnRateMovie: UIButton!
    @IBOutlet weak var collectionViewGenre: UICollectionView!
    @IBOutlet weak var collectionViewActor: UICollectionView!
    @IBOutlet weak var collectionViewCreator: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initGestureRecognizerBack()
        btnBorderColor()
        registerCollectionView()
//        GenreSamllregisterCollectionView()

        
//        btnRateMovie.isUserInteractionEnabled = false

        // Do any additional setup after loading the view.
    }
    
    private func registerCollectionView(){
        
        collectionViewActor.dataSource = self
        collectionViewActor.delegate = self
        collectionViewActor.registerForCell(identifier: BestActorCollectionViewCell.identifier)
        
        collectionViewCreator.dataSource = self
        collectionViewCreator.delegate = self
        collectionViewCreator.registerForCell(identifier: BestActorCollectionViewCell.identifier)
    }
//    private func GenreSamllregisterCollectionView(){
//
//        collectionViewGenre.dataSource = self
//        collectionViewGenre.delegate = self
//        collectionViewGenre.registerForCell(identifier: GenreSmallCollectionViewCell.identifier)
//
//    }
    
  
    
    private func initGestureRecognizerBack(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapButton))
        ivBack.isUserInteractionEnabled = true
        ivBack.addGestureRecognizer(tapGestureRecognizer)
        
        
    }

    @objc func onTapButton(){
    
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func btnBorderColor(){
        btnRateMovie.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btnRateMovie.layer.borderWidth = 1
        btnRateMovie.layer.cornerRadius = 20
    }

}
extension MovieDetailViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == collectionViewActor && (collectionViewCreator != nil){
        return 5
//        }
////        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == collectionViewActor {
            
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath) as? BestActorCollectionViewCell else {
            return UICollectionViewCell()
//        }
        
        
//        let cell = collectionView.dequeCell(identifier: BestActorCollectionViewCell.identifier, indexPath:  indexPath)
        
//        return cell
//        }
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenreSmallCollectionViewCell.self), for: indexPath) as? GenreSmallCollectionViewCell else {
//            return UICollectionViewCell()
        }
//
            return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: CGFloat(220))
    }
    
    
    
}

