//
//  MoreDatailsViewController.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/16/23.
//

import UIKit
import YouTubeiOSPlayerHelper

class DatailsViewController: UIViewController {
    
    let networkManager = NetworkManager()
    
    // MARK: Views
    @IBOutlet weak var backgroundPosterImag: UIImageView!
    @IBOutlet weak var currentPosterImage: UIImageView!
    @IBOutlet weak var mediaNameLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var starImagCollection: [UIImageView]!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    
    var media: Results?
    var genres: [Genres]?
    var video: [Video] = []
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataFilling()
        setTrailer()
    }
    
    private func dataFilling() {
        guard let media = media,
              let genres = media.genreIds else {
            return
        }
        creatPosterImage(from: media.posterPath ) { [weak self] image in
            self?.backgroundPosterImag.image = image
        }
        creatPosterImage(from: media.posterPath) { [weak self] image in
            self?.currentPosterImage.image = image
        }
        mediaNameLabel.text = media.title ?? media.name
        overViewLabel.text = media.overview
        releaseDataLabel.text = media.releaseDate ?? media.firstAirDate
        let genresString = transformationGenreToString(from: genres )
        genresLabel.text = genresString.joined(separator: " | ")
        ratingLabel.text = String(describing: media.rating )
        setingStarsImage()
    }
    
    private func transformationGenreToString(from genresId: [Int]) -> [String] {
        var genresDescription: [String] = []
        for id in genresId {
            for genre in genres ?? [] {
                if id == genre.id {
                    genresDescription.append(genre.name)
                }
            }
        }
        return genresDescription
    }
    
    private func creatPosterImage(from poster: String, comletion: @escaping((UIImage?) -> Void)) {
        
        let api = "https://image.tmdb.org/t/p/w154\(poster)"
        guard let url = URL(string: api) else {return}
        networkManager.session.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                comletion(nil)
                return
            }
            DispatchQueue.main.async {
                comletion(UIImage(data: data))
            }
        }.resume()
    }
    
    private func setTrailer() {
        loadTrailers { [weak playerView] key in
            playerView?.load(withVideoId: key)
        }
    }
    
    private func loadTrailers(completion: ((String) -> Void)?) {
        Task.init {
            do {
                guard let id = media?.id else {
                    return
                }
                video = try await networkManager.loadVideo(from: String(id))
                var key = ""
                let video = video.first {$0.type == "Trailer"}
                key = video?.key ?? ""
                completion?(key)
            } catch {
                print(error)
            }
        }
    }
   
    //MARK: Set star image
    private func setingStarsImage() {
        switch media?.rating ?? 0.0 {
        case 0...2.4:
            starImagCollection[0].image = UIImage(named: "starfill")
            starImagCollection.forEach { star in
                if star.image != UIImage(named: "starfill") {
                    star.image = UIImage(named: "star")
                }
            }
        case 2.5...5:
            starImagCollection[0].image = UIImage(named: "starfill")
            starImagCollection[1].image = UIImage(named: "starfill")
            starImagCollection.forEach { star in
                if star.image != UIImage(named: "starfill") {
                    star.image = UIImage(named: "star")
                }
            }
        case 5.1...7.5:
            starImagCollection[0].image = UIImage(named: "starfill")
            starImagCollection[1].image = UIImage(named: "starfill")
            starImagCollection[2].image = UIImage(named: "starfill")
            starImagCollection.forEach { star in
                if star.image != UIImage(named: "starfill") {
                    star.image = UIImage(named: "star")
                }
            }
        case 7.6...9:
            starImagCollection[0].image = UIImage(named: "starfill")
            starImagCollection[1].image = UIImage(named: "starfill")
            starImagCollection[2].image = UIImage(named: "starfill")
            starImagCollection[3].image = UIImage(named: "starfill")
            starImagCollection[4].image = UIImage(named: "star")
        case 9.1...10:
            starImagCollection.forEach { $0.image = UIImage(named: "starfill")}
        default:
            break
        }
    }
}
