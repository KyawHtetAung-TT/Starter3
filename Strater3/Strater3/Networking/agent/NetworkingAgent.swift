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
        AF.request(url)
            
            .responseDecodable(of: MovieListResponse.self) { response in
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
        AF.request(url)
            
            .responseDecodable(of: MovieListResponse.self) { response in
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
        AF.request(url)
            
            .responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // 4
//    func getGenreList(success : @escaping (MovieGenreList) -> Void, failure : @escaping (String) -> Void){
    func getGenreList(completion : @escaping (MDBResult<MovieGenreList>) ->  Void){
//  let url = "\(AppConstants.BaseURL)/genre/movie/list?api_key=\(AppConstants.apiKey)"
//  AF.request(url)
//  AF.request(MDBEndpoint.movieGenres.url) //URLConvertible ကိုကြော်ငြာမထားရင်အနောက်က url ကိုထည် ပေးနေရမာ
        AF.request(MDBEndpoint.movieGenres)
            .responseDecodable(of: MovieGenreList.self) { response in
            switch response.result{
            case .success(let data):
//                success(data)
                completion(.success(data))
            case .failure(let error):
//                failure(error.errorDescription!)
//                completion(.failure(error.errorDescription!))
                completion(.failure(handleError(response, error, MDBCommomResponseError.self)))

               
            }
        }
    }
    
    //5
    func getTopRatingMovieList(success : @escaping (MovieListResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/top_rated?api_key=\(AppConstants.apiKey)"
        AF.request(url)
        
            .responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    
    // 6
    func getPopularPeople(page : Int = 1, success : @escaping (ActorListResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/person/popular?page=\(page)&api_key=\(AppConstants.apiKey)"
        AF.request(url)

            .responseDecodable(of: ActorListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }

    
    // moviedetail  // showcase
    func getMovieDetailById(id : Int, success : @escaping (MovieDetailResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/\(id)?api_key=\(AppConstants.apiKey)"
        AF.request(url)
            
            .responseDecodable(of: MovieDetailResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    
    // actordetail
    func getActorDetailById(id : Int, success : @escaping (ActorDetailResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/person/\(id)?api_key=\(AppConstants.apiKey)"
        AF.request(url)
            
            .responseDecodable(of: ActorDetailResponse.self) { response in
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
        AF.request(url)
            
            .responseDecodable(of: MovieCreditResponse.self) { response in
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
        AF.request(url)
            
            .responseDecodable(of: MovieListResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    // search
//    func getSimilarMoiveCredator(query : String,page : Int, success : @escaping (MovieResult) -> Void, failure : @escaping (String) -> Void){
//       
//        let url = "\(AppConstants.BaseURL)/movie/\(id)/similar?api_key=\(AppConstants.apiKey)"
//        AF.request(url)
    
//            .responseDecodable(of: MovieResult.self) { response in
//            switch response.result{
//            case .success(let data):
//                success(data)
//            case .failure(let error):
//                failure(error.errorDescription!)
//            }
//        }
//    }
    
    // Movie Trailer
    
    func getMovieTrailerVideo(id : Int, success : @escaping (MovieTrailerResponse) -> Void, failure : @escaping (String) -> Void){
       
        let url = "\(AppConstants.BaseURL)/movie/\(id)/videos?api_key=\(AppConstants.apiKey)"
        AF.request(url)
            
            .responseDecodable(of: MovieTrailerResponse.self) { response in
            switch response.result{
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error.errorDescription!)
            }
        }
    }
    
    


  /**
    Network Error - Different Scenarios
 
 * JSON Serialization Error
 * Wrong URL Path
 * Incorrect method
 * Missing credentials
 * 4xx
 * 5xx
    
    **/
    /// 3 - Customized error body

fileprivate func handleError<T, E : MDBErrorModel>(
    _ response : DataResponse<T,AFError>,
    _ error : (AFError),
    _ errorBodyType : E.Type) -> String{
    
    var respBody : String = ""
    var serverErrorMessage : String?
    
    var errorBody : E?
    if let respData = response.data{
        respBody = String(data: respData, encoding: .utf8) ?? "empty response body"
        
        errorBody = try? JSONDecoder().decode(errorBodyType, from: respData)
        serverErrorMessage = errorBody?.message
    }


    /// 2 - Extract debug Info

    let respCode : Int = response.response?.statusCode ?? 0

    let sourcePath = response.request?.url?.absoluteString ?? "no url"


    /// 1. Essential debug info
    print(
        """
        ===================
        URL
        -> \(sourcePath)

        Status
        -> \(respCode)

        Body
        -> \(respBody)

        Underlying Error
        -> \(error.underlyingError!)

        Error Description
        -> \(error.errorDescription!)

        ===================
        """
    )

    return serverErrorMessage ?? error.errorDescription ?? "undefined"

    }
    
}

protocol MDBErrorModel : Decodable {
    var message : String { get }
}

class MDBCommomResponseError : MDBErrorModel{
    var message: String{
        return statusMessage
    }
    
    let statusMessage : String
    let statusCode : Int
    
    enum CodingKeys : String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}

enum MDBResult<T> {
    case success(T)
    case failure(String)
        
}
