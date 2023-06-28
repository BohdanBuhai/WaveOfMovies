//
//  CachingManeger.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/28/23.
//

import UIKit

final class UserDefaultsManeger {
    
    private let defaults = UserDefaults.standard
    private let key = "CachingMedia"
    
    func saveInUD(media: [Results]) {
        let data = try? JSONEncoder().encode(media)
        defaults.set(data, forKey: key)
    }
    
    func loadFromUD() async throws -> [Results] {
        guard let data = defaults.data(forKey: key)else {return []}
        
        let results = try JSONDecoder().decode([Results].self, from: data)
        
        return results
    }
}
