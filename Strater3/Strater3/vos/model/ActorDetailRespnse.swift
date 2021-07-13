//
//  ActorDetailRespnse.swift
//  Strater3
//
//  Created by Ryan Willson on 7/13/21.
//
import Foundation

// MARK: - ActorDetailResponse
public struct ActorDetailResponse: Codable {
    public  let adult: Bool?
    public  let alsoKnownAs: [String]?
    public  let biography, birthday: String?
    public  let deathday: String?
    public  let gender: Int?
    public  let homepage: String?
    public  let id: Int?
    public  let imdbID, knownForDepartment, name, placeOfBirth: String?
    public  let popularity: Double?
    public  let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, deathday, gender, homepage, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
}
