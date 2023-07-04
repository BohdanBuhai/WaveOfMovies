//
//  NetworkManeger.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/15/23.
//

import UIKit

final class NetworkManager {
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
   
    func loadMediaData(from name: String, page: Int) async throws -> Media {
        let api = "https://api.themoviedb.org/3/trending/\(name)/week?api_key=39adc08cfc9c44b11fb992d84ba47cfe&page=\(page)"
        guard let url = URL(string: api) else {return Media.init(page: 0, results: [])}
        let dataSessionResponse = try await session.data(from: url)
        let movie = try decoder.decode(Media.self, from: dataSessionResponse.0)
        
        return movie
    }
    
    func loadGenreData(from name: String) async throws -> [Genres] {
        let api = "https://api.themoviedb.org/3/genre/\(name)/list?api_key=39adc08cfc9c44b11fb992d84ba47cfe"
        guard let url = URL(string: api) else {return []}
        let dataResponse = try await session.data(from: url)
        let genre = try decoder.decode(TotalGenres.self, from: dataResponse.0)
        return genre.genres
    }
    
    func loadSearch(text: String, media type: String) async throws -> [Results] {
        let api = "https://api.themoviedb.org/3/search/\(type)?query=\(text)&api_key=39adc08cfc9c44b11fb992d84ba47cfe"
        guard let url = URL(string: api) else {
            return []
            
        }
        let dataResponse = try await session.data(from: url)
        let movie = try decoder.decode(Media.self, from: dataResponse.0)
        return movie.results
    }
    
    func loadVideo(from id: String) async throws -> [Video] {
        let api = "https://api.themoviedb.org/3/movie/\(id)/videos?language=en-US&api_key=39adc08cfc9c44b11fb992d84ba47cfe"
        guard let url = URL(string: api) else {return []}
        let dataResponse = try await session.data(from: url)
        let trailer = try decoder.decode(Trailer.self, from: dataResponse.0)
        return trailer.results
    }
    
}
