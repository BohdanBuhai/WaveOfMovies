//
//  MovieCollectionViewCell.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/14/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var fevoritButton: UIButton!
    

    var didFavore: ((Bool) -> ())?
    
    var isFavorit: Bool = false
  
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        
    }
    
    @IBAction func favoritButtonTup(_ sender: UIButton) {
        
        if isFavorit == false {
            didFavore?(isFavorit == false)
            
            fevoritButton.setImage(UIImage(named: "heartfill"), for: .normal)
           isFavorit = true
        } else {
            didFavore?(isFavorit == false)
            fevoritButton.setImage(UIImage(named: "heart"), for: .normal)
            isFavorit = false
        }
    
    }
    
     func configure(with media: Results) {

        titleLabel.text = " \(media.currentName)"
        releaseDateLabel.text = media.currentReleaseData
        loadImag(posterPath: media.posterPath)
    }
    
// MARK: load poster
    func loadImag(posterPath: String) {
        let api = "https://image.tmdb.org/t/p/w154\(posterPath)"
        guard let url = URL(string: api) else {return}
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            URLSession.shared.dataTask(with: url) {data,_,_ in
                guard let data = data else {return}
                DispatchQueue.main.async {
                    self.posterImage.image = UIImage(data: data)
                }
            } .resume()
        }
    }
    
     func definitionGenreName(from genres: [Genres], product: Results) {
        for genre in genres {
            if genre.id == product.genreIds?.first ?? 0 {
                genreLabel.text = " \(genre.name)"
            }
        }
    }
    
    
    
}
