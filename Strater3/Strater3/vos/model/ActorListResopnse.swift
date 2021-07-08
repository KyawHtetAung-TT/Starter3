//
//  ActorListResopnse.swift
//  Strater3
//
//  Created by Ryan Willson on 7/8/21.
//

import Foundation

public struct ActorListResponse : Codable {
    public let dates : Dates?
    public let page : Int?
    public let results : [ActorInfoResopnse]?
    public let totalPages, totalResults : Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}

public struct ActorInfoResopnse : Codable {
    let adult : Bool?
    let gender : Int?
    let id : Int?
    let knownFor : [MovieResult]?
    let knownForDepartment : String?
    let name : String?
    let popularity : Double?
    let profilePath : String?
    
    enum CodingKeys : String, CodingKey{
        case adult
        case gender
        case id
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name
        case popularity
        case profilePath = "profile_path"
        
    }
    
}
