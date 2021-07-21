//
//  MovieDetailViewController.swift
//  Strater3
//
//  Created by Ryan Willson on 6/3/21.
//

import UIKit


class MovieDetailViewController: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var ivBack: UIImageView!
    @IBOutlet weak var btnRateMovie: UIButton!
    @IBOutlet weak var collectionViewSmallGenre: UICollectionView!
    @IBOutlet weak var collectionViewActor: UICollectionView!
    @IBOutlet weak var collectionViewSimilarContent: UICollectionView!
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
    
    @IBOutlet weak var buttonPlayTrailer : UIButton!
    
    
    let networkAgent = MovieDBNetworkAgent.shared
    
    var movieType : MovieType?
    
    var movieID : Int = -1
    
    private var productionCompanies : [ProductionCompany] = []
    private var casts : [MovieCast] = []
    private var similarMovie : [MovieResult] = []
    private var movieTrailer : [MovieTrailer] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initGestureRecognizerBack()
        btnBorderColor()
        registerCollectionView()
        
        switch movieType {
        case .MOVIE_POPULAR:
            fetchMovieDetail(id: movieID)
        case .SERIE_POPULAR:
            fetchSeriesDetail(id: movieID)
        default:
            break
        }
        
       
        
        getMovieCreditById(id: movieID)
        fetchSimilarMovie(id: movieID)
        fetchMovieTrailer(id: movieID)
        
        seemoretapGesture()
        
//        btnRateMovie.isUserInteractionEnabled = false
      
    }
    
    private func registerCollectionView(){
       
        collectionViewActor.dataSource = self
        collectionViewActor.delegate = self
//        collectionViewActor.register(UINib(nibName:String(describing: BestActorCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BestActorCollectionViewCell.self))
        collectionViewActor.registerForCell(identifier: BestActorCollectionViewCell.identifier)
//        collectionViewActor.showsHorizontalScrollIndicator = false
//        collectionViewActor.showsVerticalScrollIndicator = false
        
        
        
        collectionViewSimilarContent.dataSource = self
        collectionViewSimilarContent.delegate = self
//        collectionViewCreator.register(UINib(nibName:String(describing: BestActorCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: BestActorCollectionViewCell.self))
        collectionViewSimilarContent.registerForCell(identifier: PopularFilmCollectionViewCell.identifier)
        
       
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
    
    // TODO :
//    private func fetchContentDetail(id : Int){
//        switch contentType {
//        case .serie:
//            fetchSerieDetail(id:id)
//        case .movie:
//            fetchMovieDetail(id:id)
//        }
//        fetchContentDetail(id: id)
//    }
    
    // movie detail data binding // showcase
    private func fetchMovieDetail(id : Int){
        networkAgent.getMovieDetailById (id: id) { (data) in
            // bind data
            self.bindData(moviedata: data)
            
        } failure: { (error) in
            print(error)
        }
    }
    
    // series detail data binding
    private func fetchSeriesDetail(id : Int){
        networkAgent.getSeriesDetailById (id: id) { (data) in
            // bind data
//            self.bindData(data: data)
            self.bindData(seriesdata: data)
        } failure: { (error) in
            print(error)
        }
    }
    
    // movie credit response / actor
    
    private func getMovieCreditById(id : Int){
        networkAgent.getMovieCreditById(id: id) { (data) in
            // Movie Credit Response
            self.casts = data.cast ?? [MovieCast]()
            self.collectionViewActor.reloadData()
        } failure: { (error) in
            print(error)
        }

    }
    
    // similar contact / you may also like these
    
    private func fetchSimilarMovie(id : Int){
        networkAgent.getSimilarMoiveCredator(id: id) { (data) in
            // creator
            self.similarMovie = data.results ?? [MovieResult]()
            self.collectionViewSimilarContent.reloadData()
        } failure: { (error) in
            print(error)
        }

    }
    
    // Movie Trailer / Youtube video
    
    private func fetchMovieTrailer(id : Int){
        networkAgent.getMovieTrailerVideo(id: id) { (data) in
            // Movie Trailer
            self.movieTrailer = data.results ?? [MovieTrailer]()
            self.buttonPlayTrailer.isHidden = self.movieTrailer.isEmpty
        } failure: { (error) in
            print(error)
        }

    }
    
    @IBAction func onClickPlayTrailer(_ sender : UIButton){
        // play
        
        let item = movieTrailer.first
        let youtubeId = item?.key
        let playVC = YouTubePlayerViewController()
        playVC.youtubeId = youtubeId
        self.present(playVC, animated: true, completion: nil)
        
        
    }
    
    // slider / popular movie
    private func bindData(moviedata : MovieDetailResponse){
        productionCompanies = moviedata.productionCompanies ?? [ProductionCompany]()
        
        collectionProductionCompanies.reloadData()
        
        let posterPath = "\(AppConstants.baseImageUrl)\(moviedata.backdropPath ?? "")"
        imageViewMoviePoster.sd_setImage(with: URL(string: posterPath))
        
        labelRelaeadedYear.text = String(moviedata.releaseDate?.split(separator:"-")[0] ?? " ")
        
        labelMovieTitle.text = moviedata.originalTitle
        
        // navigation movie title
        navigationItem.title = moviedata.originalTitle
//        self.navigationItem.title = data.originalTitle

        labelMovieDescription.text = moviedata.overview
        
//        labelDruation.text =  "\(Int((data.runtime ?? 0)/60))hr\(Int((data.runtime ?? 0) % 60))mins"
        
        let runTimeHour = Int((moviedata.runtime ?? 0)/60)
        let runTimeMinutes = ((moviedata.runtime ?? 0 ) % 60)
        labelDruation.text =  "\(runTimeHour)hr\(runTimeMinutes)mins"
        
        labelRating.text = "\(moviedata.voteAverage ?? 0)"
        viewRatingCount.rating = Int((moviedata.voteAverage ?? 0.0) * 0.5)
        labelVoteCount.text = "\(moviedata.voteCount ?? 0)votes"
        
        labelAboutMovieTitile.text = moviedata.originalTitle
        
        var genreListStr = ""
        moviedata.genres?.forEach({ (item) in
            genreListStr += "\(item.name), "
        })
        if genreListStr.count > 2{
            genreListStr.removeLast()
            genreListStr.removeLast()
        }
        

        labelGenreCollectionString.text = genreListStr
//        labelGenreCollectionString.text = data.genres?.map{$0.name}.reduce(""){"\($0), \($1)"}
    
        var countryListStr = ""
        moviedata.productionCountries?.forEach({ (item) in
            countryListStr += "\(item.name ?? ""), "
        })
        if countryListStr.count > 2 {
            countryListStr.removeLast()
            countryListStr.removeLast()
        }
        
        
        labelProductionCountriesString.text = countryListStr
        
        labelAboutMovieDescription.text = moviedata.overview
        labelReleaseData.text = moviedata.releaseDate
        
    }
    
    // slider / popular movie
    private func bindData(seriesdata : SeriesDetailResponse){
        productionCompanies = seriesdata.productionCompanies ?? [ProductionCompany]()
        
        collectionProductionCompanies.reloadData()
        
        let posterPath = "\(AppConstants.baseImageUrl)\(seriesdata.backdropPath ?? "")"
        imageViewMoviePoster.sd_setImage(with: URL(string: posterPath))
        
        labelRelaeadedYear.text = String(seriesdata.lastAirDate?.split(separator:"-")[0] ?? " ")
        
        labelMovieTitle.text = seriesdata.originalName
        
        // navigation movie title
//        navigationItem.title = seriesdata.originalName
        self.navigationItem.title = seriesdata.originalName

        labelMovieDescription.text = seriesdata.overview
        
//        labelDruation.text =  "\(Int((seriesdata.episodeRunTime ?? 0)/60))hr\(Int((seriesdata.episodeRunTime ?? 0) % 60))mins"
        
        let runTimeHour = Int((seriesdata.episodeRunTime?[0] ?? 0) / 60)
        let runTimeMinutes = ((seriesdata.episodeRunTime?[0] ?? 0 ) % 60)
        labelDruation.text =  "\(runTimeHour)hr\(runTimeMinutes)mins"
        
        labelRating.text = "\(seriesdata.voteAverage ?? 0)"
        viewRatingCount.rating = Int((seriesdata.voteAverage ?? 0.0) * 0.5)
        labelVoteCount.text = "\(seriesdata.voteCount ?? 0)votes"
        
        labelAboutMovieTitile.text = seriesdata.originalName
        
        var genreListStr = ""
        seriesdata.genres?.forEach({ (item) in
            genreListStr += "\(item.name), "
        })
        if genreListStr.count > 2{
            genreListStr.removeLast()
            genreListStr.removeLast()
        }
        

//        labelGenreCollectionString.text = genreListStr
        labelGenreCollectionString.text = seriesdata.genres?.map{$0.name}.reduce(""){"\($0), \($1)"}
    
        var countryListStr = ""
        seriesdata.productionCountries?.forEach({ (item) in
            countryListStr += "\(item.name ?? ""), "
        })
        if countryListStr.count > 2 {
            countryListStr.removeLast()
            countryListStr.removeLast()
        }
        
        
        labelProductionCountriesString.text = countryListStr
        
        labelAboutMovieDescription.text = seriesdata.overview
        labelReleaseData.text = seriesdata .lastAirDate
        self.navigationItem.title = seriesdata.originalName
        
    }
    @objc func onTapButton(){
    
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func btnBorderColor(){
        btnRateMovie.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btnRateMovie.layer.borderWidth = 1
        btnRateMovie.layer.cornerRadius = 20
        
        self.buttonPlayTrailer.isHidden = true
    }

}
extension MovieDetailViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionProductionCompanies{
            return productionCompanies.count
        }else if collectionView == collectionViewActor{
            return casts.count
        }else if collectionView == collectionViewSmallGenre{
            return 2
        }else if collectionView == collectionViewSimilarContent{
            return similarMovie.count
        }else{
            return 0
        }
   
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if collectionView == collectionViewActor{
//
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath) as? BestActorCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            return cell
//        }else
        if collectionView == collectionViewActor{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BestActorCollectionViewCell.self), for: indexPath) as? BestActorCollectionViewCell else {
                return UICollectionViewCell()
            }
            let item : MovieCast = casts[indexPath.row]
            cell.data = item.converToActorInfoResopnse()
            return cell
        }
        
        else if collectionView == collectionViewSmallGenre{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GenreSmallCollectionViewCell.self), for: indexPath) as? GenreSmallCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }else if collectionView == collectionViewSimilarContent{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PopularFilmCollectionViewCell.self), for: indexPath) as? PopularFilmCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = similarMovie[indexPath.row]
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
            let itemWidth : CGFloat = collectionView.frame.height
            let itemHeight = itemWidth
            return CGSize(width: itemWidth, height: itemHeight)

        }else if collectionView == collectionViewActor{
            let itemWidth : CGFloat = 120
            let itemHeght : CGFloat = itemWidth * 1.5
            return CGSize(width: itemWidth, height: itemHeght)

        }else if collectionView == collectionViewSmallGenre{
            let itemWidth : CGFloat = 100
            let itemHeght : CGFloat = 30
            return CGSize(width: itemWidth, height: itemHeght)

        }else if collectionView == collectionViewSimilarContent{
            let itemWidth : CGFloat = 120
            let itemHeght : CGFloat = itemWidth * 1.5
            return CGSize(width: itemWidth, height: itemHeght)
        }
        else{
            return CGSize.zero
//            return CGSize(width: collectionView.frame.width/2.5, height: CGFloat(220))
        }
        

    }


    // see more
    func seemoretapGesture(){
        
        labelMovieDescription.numberOfLines = 4
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.labelAction(gesture:)))
        labelMovieDescription.addGestureRecognizer(tap)
        labelMovieDescription.isUserInteractionEnabled = true
        tap.delegate = self
    }
        
    // See more
    @objc func labelAction(gesture: UITapGestureRecognizer){
           if labelMovieDescription.numberOfLines == 0 {
            labelMovieDescription.numberOfLines = 4
            
           } else {
            labelMovieDescription.numberOfLines = 0
           }
    }
   

}


    
            
    

    
    


