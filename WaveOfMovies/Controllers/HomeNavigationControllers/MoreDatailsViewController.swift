//
//  MoreDatailsViewController.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/16/23.
//

import UIKit

class MoreDatailsViewController: UIViewController {
    
    // MARK: Views
    @IBOutlet weak var backgroundPosterImag: UIImageView!
    @IBOutlet weak var currentPosterImage: UIImageView!
    @IBOutlet weak var mediaNameLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var starsImage: [UIImageView]!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var playerView: UIView!
    
    var media: Product?
    var genres: [Genres]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundPosterImag.image = UIImage(named: media?.posterPath ?? "no image")
        currentPosterImage.image = UIImage(named: media?.posterPath ?? "") ?? UIImage(named: "Frame")
        mediaNameLabel.text = media?.title ?? media?.name
        overViewLabel.text = media?.overview
        releaseDataLabel.text = media?.releaseDate ?? media?.firstAirDate
        genresLabel.text = transformationGenreToString(from: media?.genreIds ?? [])
        ratingLabel.text = String(describing: media?.rating ?? 0)
        starsImage.forEach { star in
            star.image = UIImage(named: "star")
        }
    }
    
    private func transformationGenreToString(from genresId: [Int]) -> String {
        var genresDescription: String = ""
        for id in genresId {
            for genre in genres ?? [] {
                if id == genre.id {
                    genresDescription += " \(genre.name)"
                }
            }
        }
        return genresDescription
    }
    
}
