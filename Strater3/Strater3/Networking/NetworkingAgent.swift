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
    
    private init() { }
    
    func getPopularMovieList(success : @escaping (MovieListResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/popular?.api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
                    
            }
            
        }
    
    }
    
    
    func getUpcomingMovieList(success : @escaping (MovieListResponse) -> Void, failure : @escaping (String) -> Void){

        let url = "\(AppConstants.BaseURL)/movie/upcoming?.api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let upcomingMovieList):
                success(upcomingMovieList)
            case .failure(let error):
                failure(error.errorDescription!)
                    
            }
            
        }
    
    }

    func getPopularSeriesList(success : @escaping (MovieListResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/tv/popular?.api_key=\(AppConstants.apiKey)"

        AF.request(url).responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
                    
            }
            
        }
    
    }


}
