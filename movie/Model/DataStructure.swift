//
//  DataStructure.swift
//  movie
//
//  Created by Samsud Dhuha on 29/07/21.
//

import Foundation


struct Genre: Decodable {
    var name: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
    }
}

struct Movie: Decodable {
    var adult: Bool?
    var backdropPath, title, overview, posterPath, releaseDate: String?
    var id, voteCount: Int?
    var voteAverage: Float?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case title = "title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case adult = "adult"
        case id = "id"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}


struct ResultVideo: Decodable {
    var key: String?
}
