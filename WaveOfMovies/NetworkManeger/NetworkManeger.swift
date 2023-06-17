//
//  NetworkManeger.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/15/23.
//

import Foundation

final class NetworkManeger {
   
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func loadMediaData(from name: String, page: Int) async throws -> [Product] {
        let api = "https://api.themoviedb.org/3/trending/\(name)/week?api_key=39adc08cfc9c44b11fb992d84ba47cfe&page=\(page)"
        let url = URL(string: api)!
        let dataSessionResponse = try await session.data(from: url)
        let movie = try decoder.decode(Media.self, from: dataSessionResponse.0)
        return movie.results
    }
    
    func loadGenreData(from name: String) async throws -> [Genres] {
        let api = "https://api.themoviedb.org/3/genre/\(name)/list?api_key=39adc08cfc9c44b11fb992d84ba47cfe"
        let url = URL(string: api)!
        let dataResponse = try await session.data(from: url)
        let genre = try decoder.decode(TotalGenres.self, from: dataResponse.0)
        return genre.genres
    }
    
}
