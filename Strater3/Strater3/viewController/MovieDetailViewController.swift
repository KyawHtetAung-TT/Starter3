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
    @IBOutlet weak var collectionViewSmallGenre: UICollectionView!
    @IBOutlet weak var collectionViewActor: UICollectionView!
    @IBOutlet weak var collectionViewCreator: UICollectionView!
    @IBOutlet weak var collectionProductionCompanies: UICollectionView!
    
    @IBOutlet weak var labelRelaeadedYear : UILabel!
    @IBOutlet weak var labelMovieTitle : UILabel!
    @IBOutlet weak var labelMovieDescription : UILabel!
    @IBOutlet weak var labelDruation : UILabel!
    @IBOutlet weak var labelRating : UILabel!
    @IBOutlet weak var viewRatingCount : RatingControl!
    @IBOutlet weak var labelVoteCount : UILabel!
    
    @IBOutlet weak var labelAboutMovieTitile : UILabel!
    @IBOutlet weak var labelGenreCollectionString : UILabel!
    @IBOutlet weak var labelProductionCountriesString : UILabel!
    @IBOutlet weak var labelAboutMovieDescription : UILabel!
    @IBOutlet weak var labelReleaseData : UILabel!
    @IBOutlet weak var imageViewMoviePoster : UIImageView!
    
    
    let networkAgent = MovieDBNetworkAgent.shared
    
    var movieID : Int = -1
    
    private var productionCompanies : [ProductionCompany] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        initGestureRecognizerBack()
        btnBorderColor()
        registerCollectionView()
        
        fetchMovieDetail(id: movieID)
        
//        btnRateMovie.isUserInteractionEnabled = false

        // Do any additional setup after loading the view.
        
    }
    
    private func registerCollectionView(){
        
        collectionViewActor.dataSource = self
        collectionViewActor.delegate = self
//        collectionViewActor.register(UINib(nibName:String(describing: BestActorCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BestActorCollectionViewCell.self))
        collectionViewActor.registerForCell(identifier: BestActorCollectionViewCell.identifier)
        
        
        
        collectionViewCreator.dataSource = self
        collectionViewCreator.delegate = self
//        collectionViewCreator.register(UINib(nibName:String(describing: BestActorCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BestActorCollectionViewCell.self))
        collectionViewCreator.registerForCell(identifier: BestActorCollectionViewCell.identifier)
        
       
        collectionProductionCompanies.dataSource = self
        collectionProductionCompanies.delegate = self
//        collectionProductionCompanies.register(UINib(nibName:String(describing: ProudctionCompanyCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProudctionCompanyCollectionViewCell.self))
        collectionProductionCompanies.registerForCell(identifier: ProudctionCompanyCollectionViewCell.identifier)
        
        collectionViewSmallGenre.dataSource = self
        collectionViewSmallGenre.delegate = self
        collectionViewSmallGenre.registerForCell(identifier: GenreSmallCollectionViewCell.identifier)
    }
    
    private func initGestureRecognizerBack(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapButton))
        ivBack.isUserInteractionEnabled = true
        ivBack.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    // movie detail data binding
    private func fetchMovieDetail(id : Int){
        networkAgent.getMovieDetailById (id: id) { (data) in
            // bind data
            self.bindData(data: data)
            
        } failure: { (error) in
            print(error)
        }
    }
    
    private func bindData(data : MovieDetailResponse){
        productionCompanies = data.productionCompanies ?? [ProductionCompany]()
        
        collectionProductionCompanies.reloadData()
        let posterPath = "\(AppConstants.baseImageUrl)\(data.backdropPath ?? "")"
        imageViewMoviePoster.sd_setImage(with: URL(string: posterPath))
        
        labelRelaeadedYear.text = String(data.releaseDate?.split(separator:"-")[0] ?? " ")
        
        labelMovieTitle.text = data.originalTitle
        labelMovieDescription.text = data.overview
        
//        labelDruation.text =  "\(Int((data.runtime ?? 0)/60))hr\(Int((data.runtime ?? 0) % 60))mins"
        
        let runTimeHour = Int((data.runtime ?? 0)/60)
        let runTimeMinutes = ((data.runtime ?? 0 ) - runTimeHour)
        labelDruation.text =  "\(runTimeHour)hr\(runTimeMinutes)"
        
        labelRating.text = "\(data.voteAverage ?? 0)"
        viewRatingCount.rating = Int((data.voteAverage ?? 0.0) * 0.5)
        labelVoteCount.text = "\(data.voteCount ?? 0)votes"
        
        labelAboutMovieTitile.text = data.originalTitle
        
        var genreListStr = ""
        data.genres?.forEach({ (item) in
            genreListStr += "\(item.name), "
        })
        genreListStr.removeLast()
        genreListStr.removeLast()

        labelGenreCollectionString.text = genreListStr
//        labelGenreCollectionString.text = data.genres?.map{$0.name}.reduce(""){"\($0), \($1)"}
    
        var countryListStr = ""
        data.productionCountries?.forEach({ (item) in
            countryListStr += "\(item.name ?? ""), "
        })
        countryListStr.removeLast()
        countryListStr.removeLast()
        
        labelProductionCountriesString.text = countryListStr
        
        labelAboutMovieDescription.text = data.overview
        labelReleaseData.text = data.releaseDate
        
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
        if collectionView == collectionProductionCompanies{
            return productionCompanies.count
        }else if collectionView == collectionViewSmallGenre{
            return 3
        }else{
            return 5
        }
   
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewActor{
            // TODO:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath) as? BestActorCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }else if collectionView == collectionViewSmallGenre{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenreSmallCollectionViewCell.self), for: indexPath) as? GenreSmallCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }else if collectionView == collectionViewCreator{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath) as? BestActorCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProudctionCompanyCollectionViewCell.self), for: indexPath) as? ProudctionCompanyCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = self.productionCompanies[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionProductionCompanies {
//            let itemWidth : CGFloat = 200
//            let itemHeight = itemWidth
            return CGSize(width: 200, height: 200)
        }else{
        return CGSize(width: collectionView.frame.width/2, height: CGFloat(220))
            }
    }





}


    
            
    

    
    


