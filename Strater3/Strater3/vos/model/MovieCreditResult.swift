//
//  MovieCreditResult.swift
//  Strater3
//
//  Created by Ryan Willson on 7/9/21.
//

// This file was generated from JSON Schema using quicktype
// To parse the JSON, add this file to your project and do:
//
//   let movieCast = try? newJSONDecoder().decode(MovieCast.self, from: jsonData)

import Foundation

// MARK: - MovieCreditResponse
struct MovieCreditResponse: Codable {
    let id: Int?
    let cast, crew: [MovieCast]?
}

// MARK: - MovieCast
struct MovieCast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    func converToActorInfoResopnse()-> ActorInfoResopnse{
        return ActorInfoResopnse(adult: self.adult,
                                 gender: self.gender,
                                 id: self.id,
                                 knownFor: nil,
                                 knownForDepartment: self.knownForDepartment,
                                 name: self.name,
                                 popularity: self.popularity,
                                 profilePath: self.profilePath)
    }
    
    
}
