//
//  ViewController.swift
//  Strater3
//
//  Created by kyaw htet aung on 2021/01/28.
//

import UIKit

class MovieViewController: UIViewController,MovieItemDelegate {
    
    @IBOutlet weak var tableViewMovies: UITableView!
    @IBOutlet weak var viewForToolbar: UIView!
    @IBOutlet weak var ivMenu: UIImageView!
    @IBOutlet weak var ivSearch: UIImageView!
    
    private let networkAgent = MovieDBNetworkAgent.shared

    private var upcomingMovieList : MovieListResponse?
    private var popularMovieList: MovieListResponse?
    private var popularSeriesList: MovieListResponse?
    private var topRatingMovieList : MovieListResponse?
    
    private var genresMovieList: MovieGenreList?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        registerTableViewCell()
        fetchUpcomingMovieList()
        fetchPopularMovieList()
        fetchPopularSeriesList()
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
    
    func onTapMovie() {
        
        nevigateToMovieDetailViewController()
        
    }
    
    func fetchMoiveGenreList(){
        
        networkAgent.getGenreList { (data) in
            self.genresMovieList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: 4), with: .automatic)
        } failure: { (error) in
            print(error.description)
        }
        
    }
    func fetchTopRaingMovieList(){
        
        networkAgent.getTopRatingMovieList { (data) in
            self.topRatingMovieList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: 4), with: .automatic)
        } failure: { (error) in
            print(error.description)
        }
    }
    
    
    
    func fetchUpcomingMovieList(){
        
        networkAgent.getUpcomingMovieList { (data) in
            self.upcomingMovieList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: 0), with: .automatic)
        } failure: { (error) in
            print(error.description)
        }
    }
    
    func fetchPopularMovieList(){
        
        networkAgent.getUpcomingMovieList { (data) in
            self.popularMovieList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: 1), with: .automatic)
        } failure: { (error) in
            print(error.description)
        }
    }
    func fetchPopularSeriesList(){
        
        networkAgent.getUpcomingMovieList { (data) in
            self.popularMovieList = data
            // UI update
            self.tableViewMovies.reloadSections(IndexSet(integer: 2), with: .automatic)
        } failure: { (error) in
            print(error.description)
        }
    }
    
    
}
    
extension MovieViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
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
        
        
        case MovieType.MOVIE_SLIDER.rawValue:
            let cell = tableView.dequeCell(identifier: MovieSliderTableViewCell.identifier, indexPath: indexPath) as MovieSliderTableViewCell

            cell.delegate = self
            cell.data = upcomingMovieList
            
            return cell
           
            
        case MovieType.MOVIE_POPULAR.rawValue:
//            return tableView.dequeCell(identifier: PopularFilmTableViewCell.identifier, indexPath: indexPath)
            
            let cell = tableView.dequeCell(identifier: PopularFilmTableViewCell.identifier, indexPath: indexPath) as PopularFilmTableViewCell
            cell.delegate = self
            cell.lableTitle.text = "popular moives".uppercased()
            cell.data = popularMovieList
            return cell

        case MovieType.SERIE_POPULAR.rawValue:
            
            let cell = tableView.dequeCell(identifier: PopularFilmTableViewCell.identifier, indexPath: indexPath) as PopularFilmTableViewCell
            cell.delegate = self
            cell.lableTitle.text = "popular series".uppercased()
            cell.data = popularSeriesList
            return cell
            
            
            
        case MovieType.MOVIE_SHOWTIME.rawValue:
            let cell = tableView.dequeCell(identifier: MovieShowTImeTableViewCell.identifier, indexPath: indexPath)
            return cell
            
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
            
        case MovieType.MOVIE_SHOWCASE.rawValue:
            let cell = tableView.dequeCell(identifier: ShowCaseTableViewCell.identifier, indexPath: indexPath)
            return cell
            
        case MovieType.MOVIE_BESTACTOR.rawValue:
            let cell = tableView.dequeCell(identifier: BestActorTableViewCell.identifier, indexPath: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
    
}
