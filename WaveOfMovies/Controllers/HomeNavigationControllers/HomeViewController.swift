//
//  ViewController.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/12/23.
//


import UIKit

// MARK: class HomeViewController:
final class HomeViewController: UIViewController {
    
    let movie = "movie"
    let tv = "tv"
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var moviesCollectinView: UICollectionView!
    var mediaCollection: [Product] = []
    var genresCollection: [Genres] = []
    
    let networkManeger = NetworkManeger()
    let session = URLSession.shared
    
    let titleTextColorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollectinView.dataSource = self
        moviesCollectinView.delegate = self
        segmentController.setTitleTextAttributes(titleTextColorAttributes, for: .selected)
        if segmentController.selectedSegmentIndex == 0 {
            writeDatafor(media: movie, page: 1)
        }
    }
    
    @IBAction func segmentControllerAction(_ sender: Any) {
        if segmentController.selectedSegmentIndex == 0 {
            writeDatafor(media: movie, page: 1)
        } else if segmentController.selectedSegmentIndex == 1 {
            writeDatafor(media: tv, page: 1)
        }
    }
    
    private func writeDatafor(media name: String, page: Int) {
        Task.init {
            do {
                mediaCollection = try await networkManeger.loadMediaData(from: name, page: page)
                genresCollection = try await networkManeger.loadGenreData(from: name)
                
            } catch {
                print(error)
            }
            moviesCollectinView.reloadData()
        }
    }
    
    func ceatUrlFoPoster(form api: String) -> URL {
        let api = "https://image.tmdb.org/t/p/original\(api)"
        let url = URL(string: api)!
        return url
    }
    
    func load(poster: String) -> Data {
        var data = Data()
        let api = "https://image.tmdb.org/t/p/original\(poster)"
        let url = URL(string: api)!
        Task.init {
            let posterImage = try await session.data(from: url)
            data = posterImage.0
        }
        return data
    }
}

// MARK: Extension to CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        mediaCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell",for: indexPath)
        guard let myCell = cell as? MovieCollectionViewCell else {return UICollectionViewCell()}
        
        let film = mediaCollection[indexPath.row]
        myCell.fevoritButton.setImage(UIImage(named: "heart"), for: .normal)
        myCell.titleLabel.text = film.currentName
        myCell.releaseDateLabel.text = film.currentReleaseData
        for genre in genresCollection {
            if genre.id == film.genreIds.first ?? 0 {
                myCell.genreLabel.text = genre.name
            }
        }
        session.dataTask(with: ceatUrlFoPoster(form: film.posterPath)) {data,_,_ in
            guard let data = data else {return}
            DispatchQueue.main.async {
                myCell.posterImage.image = UIImage(data: data)
            }
        } .resume()
        return myCell
    }
}

//MARK: Extension to CollectionVoewDeledat
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard
            let ditailsVc = storyboard?.instantiateViewController(withIdentifier: "MoreDatailsViewController") as? MoreDatailsViewController
        else {return}
        let selectedMedia = mediaCollection[indexPath.item]
        ditailsVc.genres = genresCollection
        ditailsVc.media = selectedMedia
        
        navigationController?.pushViewController(ditailsVc, animated: true)
    }
}

