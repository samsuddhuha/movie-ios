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
}

struct Movie: Decodable {
    var adult: Bool?
    var backdrop_path, title, overview, poster_path, release_date: String?
    var id, vote_count: Int?
    var vote_average: Float?
}


struct ResultVideo: Decodable {
    var key: String?
}
