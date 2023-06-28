//
//  DataFlowManeger.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/28/23.
//

import UIKit

final class DataFlowManeger {
    let networkManeger = NetworkManeger()
    let cachingManeger = UserDefaultsManeger()
    
//    func loadData() async throws -> Media {
//        var media: Media = .init(page: 0, results: [])
//        let cachedMedia = try await cachingManeger.loadFromUD()
//        if cachedMedia != nil {
//            media = cachedMedia
//        } else {
//            
//        }
//        return media
//    }
    
    
}

