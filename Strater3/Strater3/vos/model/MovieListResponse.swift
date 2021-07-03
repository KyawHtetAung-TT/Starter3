//
//  UpcomingMovieLIst.swift
//  NetworkLayer
//
//  Created by Ryan Willson on 7/1/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let upcomingMoiveList = try? newJSONDecoder().decode(UpcomingMoiveList.self, from: jsonData)

import Foundation


// MARK: - UpcomingMoiveList
public struct MovieListResponse : Codable {
    public let dates : Dates?
    public let page : Int?
    public let results : [MovieResult]?
    public let totalPages, totalResults : Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public init(dates : Dates?, page : Int?, results : [MovieResult]?, totalPages : Int?, totalResults : Int?){
        
        self.dates = dates
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
        
    }
    
}

// MARK: - Dates
public struct Dates: Codable {
    public let maximum, minimum: String?
    
    public init(maximum : String?, minimum : String?){
        self.maximum = maximum
        self.minimum = minimum
    }
    
}

// MARK: - MovieResult
public struct MovieResult: Codable, Hashable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, originalName, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    public init(adult : Bool?, backdropPath: String?, genreIDS: [Int]?, id: Int?, originalLanguage: String?, originalName : String?, originalTitle : String?, overview: String? , popularity: Double?, posterPath : String?, releaseDate : String?, title: String?, video: Bool? ,voteAverage: Double?, voteCount: Int?){
        
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        
        
        
    }
    
    
    
    
}

public enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
    case es = "es"
}

