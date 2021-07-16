//
//  ViewController.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/28.
//

import UIKit

class MovieViewController: UIViewController,MovieItemDelegate,ActorDetailDelegate,ShowcaseItemDelegate,moreShowcaseDelegate,viewMoreActorDelegate {
    
  
    @IBOutlet weak var tableViewMovies: UITableView!
  
    
    // network call function
    private let networkAgent = MovieDBNetworkAgent.shared

    private var upcomingMovieList : MovieListResponse?
    private var popularMovieList: MovieListResponse?
    private var popularSeriesList: MovieListResponse?
    private var topRatingMovieList : MovieListResponse?
    private var genresMovieList: MovieGenreList?
    private var popularPeople: ActorListResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerTableViewCell()
    
        fetchUpcomingMovieList()
        fetchPopularMovieList()
        fetchMoiveGenreList()
        fetchTopRaingMovieList()
        fetchPopularSeriesList()
        fetchPopularPeople()
    }
  
    
    @IBAction func SearchBarButtonItem(_ sender: Any) {
        
        let searchVC = SearchContentViewController()
        self.present(searchVC, animated: true, completion: nil)
        searchVC.modalPresentationStyle = .automatic
        searchVC.modalTransitionStyle = .crossDissolve
        
    }
    
    
    
    
    private func registerTableViewCell(){
        tableViewMovies.dataSource = self
        
//        tableViewMovies.register(UINib(nibName: String(describing: MovieSliderTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieSliderTableViewCell.self))
        
        tableViewMovies.registerForCell(identifier: MovieSliderTableViewCell.identifier)
        tableViewMovies.registerForCell(identifier: PopularFilmTableViewCell.identifier)
        tableViewMovies.registerForCell(identifier: MovieShowTImeTableViewCell.identifier)
        tableViewMovies.registerForCell(identifier: GenreTableViewCell.identifier)
        tableViewMovies.registerForCell(identifier: ShowCaseTableViewCell.identifier)
        tableViewMovies.registerForCell(identifier: BestActorTableViewCell.identifier)
    }
    func onTapViewMoreActor() {
        nevigateToViewMoreActorViewController()
    }
    func onTapShowcaselabel() {
        nevigateToMoreShowcaseViewController()
    }
    func onTapMovie(id: Int) {
        nevigateToMovieDetailViewController(movieId: id )
    }
    func onTapActorDetail(id : Int) {
        nevigateToActorDetailViewController(actorId: id )
    }
    func onTapShowcase(id : Int) {
        nevigateToMovieDetailViewController(movieId: id )
    }
    
    
    // 1
    func fetchUpcomingMovieList(){
        
        networkAgent.getUpcomingMovieList { (data) in
            self.upcomingMovieList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: MovieType.MOVIE_SLIDER.rawValue), with: .automatic)
            
        } failure: { (error) in
            print(error.description)
            
        }
    }
    
    // 2
    func fetchPopularMovieList(){
        
        networkAgent.getPopularMovieList { (data) in
            self.popularMovieList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: MovieType.MOVIE_POPULAR.rawValue), with: .automatic)
        } failure: { (error) in
            print(error.description)
        }
    }
    
    // 3
    func fetchPopularSeriesList(){
        
        networkAgent.getPopularSeriesList { (data) in
            self.popularSeriesList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: MovieType.SERIE_POPULAR.rawValue), with: .automatic)
        } failure: { (error) in
            print(error.description)
        }
    }
    
    // 4
    func fetchMoiveGenreList(){
        
        networkAgent.getGenreList { (data) in
            self.genresMovieList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: MovieType.MOVIE_GENRE.rawValue), with: .automatic)
        } failure: { (error) in
            print(error.description)
            
        }
    }

    //5
    func fetchTopRaingMovieList(){
        networkAgent.getTopRatingMovieList { (data) in
            self.topRatingMovieList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: MovieType.MOVIE_SHOWCASE.rawValue), with: .automatic)
        } failure: { (error) in
            print(error.description)
        }
    }
    
    // 6
    func fetchPopularPeople(){
        networkAgent.getPopularPeople { (data) in
            self.popularPeople = data
//            print("popularpeople : \(self.popularPeople?.results?.count ?? 0)")
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: MovieType.MOVIE_BESTACTOR.rawValue), with: .automatic)
        } failure: { (error) in
            print(error.description)
            
        }
    }


}
extension MovieViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
//        case 0 :
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieSliderTableViewCell.self, for: indexPath) as? MovieSliderTableViewCell else {
//                return UITableViewCell()
//            }
//            return cell
        
        // 1
        case MovieType.MOVIE_SLIDER.rawValue:
            let cell = tableView.dequeCell(identifier: MovieSliderTableViewCell.identifier, indexPath: indexPath) as MovieSliderTableViewCell

            cell.delegate = self
            cell.data = upcomingMovieList
            
            return cell
           
        // 2
        case MovieType.MOVIE_POPULAR.rawValue:
//            return tableView.dequeCell(identifier: PopularFilmTableViewCell.identifier, indexPath: indexPath)
            
            let cell = tableView.dequeCell(identifier: PopularFilmTableViewCell.identifier, indexPath: indexPath) as PopularFilmTableViewCell
            cell.delegate = self
            cell.lableTitle.text = "popular moives".uppercased()
            cell.data = popularMovieList
            return cell

        // 3
        case MovieType.SERIE_POPULAR.rawValue:
            
            let cell = tableView.dequeCell(identifier: PopularFilmTableViewCell.identifier, indexPath: indexPath) as PopularFilmTableViewCell
            cell.delegate = self
            cell.lableTitle.text = "popular series".uppercased()
            cell.data = popularSeriesList
            
            return cell
            
            
        // 4
        case MovieType.MOVIE_GENRE.rawValue:
            let cell = tableView.dequeCell(identifier: GenreTableViewCell.identifier, indexPath: indexPath) as GenreTableViewCell

            var movieList : [MovieResult] = []
            movieList.append(contentsOf: upcomingMovieList?.results ?? [MovieResult]())
            movieList.append(contentsOf: popularSeriesList?.results ?? [MovieResult]())
            movieList.append(contentsOf: popularMovieList?.results ?? [MovieResult]())
            cell.allMoivieAndSeries = movieList
            
            let resultData : [GenreVO]? = genresMovieList?.genres.map({ movieGenres -> GenreVO in
                return movieGenres.convertToGenreVO()
            })
            
            resultData?.first?.isSelected = true
            cell.genreList = resultData
           
            return cell
            
        //
        case MovieType.MOVIE_SHOWTIME.rawValue:
            let cell = tableView.dequeCell(identifier: MovieShowTImeTableViewCell.identifier, indexPath: indexPath) as MovieShowTImeTableViewCell
            
            return cell
            
            
        // 5
        case MovieType.MOVIE_SHOWCASE.rawValue:
            let cell = tableView.dequeCell(identifier: ShowCaseTableViewCell.identifier, indexPath: indexPath) as ShowCaseTableViewCell
            
            cell.delegate = self
            cell.data = topRatingMovieList
            cell.delegateshowcase = self
            
            return cell
            
            
        // 6
        case MovieType.MOVIE_BESTACTOR.rawValue:
            let cell = tableView.dequeCell(identifier: BestActorTableViewCell.identifier, indexPath: indexPath) as BestActorTableViewCell
            
            cell.data = popularPeople
            cell.delegate = self
            cell.delegateViewMoreActor = self
            return cell
            
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
}
