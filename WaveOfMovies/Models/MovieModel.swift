//
//  MovieModel.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/14/23.
//

import Foundation
//MARK: Model fo Media

struct Media : Codable {
    let page : Int
    let results : [Results]
}

struct Results : Codable {
    let id : Int
    var title : String?
    let name: String?
    let overview : String
    var posterPath : String
    let genreIds : [Int]?
    let releaseDate : String?
    let firstAirDate: String?
    let rating: Double?
    let mediaType: String?
    
    var currentName: String {
        title ?? name ?? ""
    }
    var currentReleaseData: String {
        releaseDate ?? firstAirDate ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case name
        case overview = "overview"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case rating = "vote_average"
        case mediaType = "media_type"
    }
}

    //MARK: Model fo trailer
struct Trailer: Codable {
    let results: [Video]
}
struct Video: Codable {
    let key: String
    let type: String
}


//MARK: Model fo Genres
struct Genres: Codable {
    let id: Int
    let name: String
  }

struct TotalGenres: Codable {
    let genres: [Genres]
}
