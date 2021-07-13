//
//  NetworkingAgent.swift
//  Strater3
//
//  Created by Ryan Willson on 7/2/21.
//

import Foundation
import Alamofire

struct MovieDBNetworkAgent {

    static let shared = MovieDBNetworkAgent()
    
    private init() { } // initialization ကိုပိတ်တာ
    
    // network call သည် asynchronous ဖြစ်လို @escaping သုံးရတာ
    // 1
    
    func getUpcomingMovieList(success : @escaping (MovieListResponse) -> Void, failure : @escaping (String) -> Void){

        let url = "\(AppConstants.BaseURL)/movie/upcoming?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let upcomingMovieList):
                success(upcomingMovieList)
//                upcomingMovieList.results?.forEach{
//                    debugPrint($0.originalTitle)
//                }
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // 2
    
    func getPopularMovieList(success : @escaping (MovieListResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/popular?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }

    // 3
    func getPopularSeriesList(success : @escaping (MovieListResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/tv/popular?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // 4
    func getGenreList(success : @escaping (MovieGenreList) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/genre/movie/list?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieGenreList.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    //5
    func getTopRatingMovieList(success : @escaping (MovieListResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/top_rated?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    
    // 6
    func getPopularPeople(success : @escaping (ActorListResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/person/popular?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: ActorListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }

    // moviedetail
    func getMovieDetailById(id : Int, success : @escaping (MovieDetailResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/\(id)?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieDetailResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // moviecredit / actor
    func getMovieCreditById(id : Int, success : @escaping (MovieCreditResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/\(id)/credits?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieCreditResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // similar contact / you may also like these
    
    func getSimilarMoiveCredator(id : Int, success : @escaping (MovieListResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/\(id)/similar?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    // Movie Trailer
    
    func getMovieTrailerVideo(id : Int, success : @escaping (MovieTrailerResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/\(id)/videos?api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieTrailerResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
}
