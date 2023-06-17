//
//  ModelTv.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/14/23.
//

import Foundation

// MARK: - Welcome
struct Tv: Codable {
    let page: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let backdropPath: String
    let id: Int
    let name: String
    let overview: String
    let posterPath: String
    let genreIDS: [Int]
    let firstAirDate: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case firstAirDate = "first_air_date"
    }
}




