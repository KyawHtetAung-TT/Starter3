//
//  Models.swift
//  NetworkLayer
//
//  Created by Ryan Willson on 6/27/21.
//

import Foundation

//
//struct LoginSuccess : Codable {
//    let success : Bool?
//    let statusCode : Int?
//    let statusMessage : String?
//
//    enum  CodingKeys: String, CodingKey {
//        case success
//        case statusCode = "status_code"
//        case statusMessage = "status_message"
//    }
//}

struct LoginSuccess : Codable {
    let success : Bool?
    let expiresAt : String?
    let requstToken : String?
    
    enum  CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requstToken = "request_token"
    }
}

struct LoginFailed : Codable {
    let success : Bool?
    let statusCode : Int?
    let statusMessage : String?
    
    enum  CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
}

struct LoginReqeust : Codable {
    let username : String
    let password : String
    let reqeustToken : String

    enum  CodingKeys: String, CodingKey {
        case username
        case password
        case reqeustToken = "reqeust_message"
    }
}

struct RequestTokenResponse : Codable {
    let success : Bool
    let expiresAt : String
    let reqeustToken : String

    enum  CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case reqeustToken = "request_token"
    }
}


struct MovieGenreList : Codable {
    let genres : [MoiveGenre]
}


public struct MoiveGenre : Codable{
    public let id : Int
    public let name : String
    
    enum CodingKeys : String, CodingKey {
        case id
        case name  
    }
//    let anotherProperty : String?   // data မပါရင်သုံးဖို
    func convertToGenreVO() -> GenreVO{
        let vo = GenreVO(id: id, name: name, isSelected: false)
        return vo
    }
    
}

var movieGenres = [MoiveGenre]()
