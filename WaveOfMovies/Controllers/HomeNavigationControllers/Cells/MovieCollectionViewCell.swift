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
    
    @IBAction func favoritButtonTup(_ sender: UIButton) {
        print("hello")
        if sender.isSelected == false {
            fevoritButton.setImage(UIImage(named: "heartfill"), for: .normal)
            fevoritButton.isSelected = true
        
        }
    }
    
    
    
}
