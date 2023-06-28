//
//  ViewController.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/12/23.
//


import UIKit


// MARK: class HomeViewController:
final class HomeViewController: UIViewController {
    var taypeMedia = "movie"
    
    let networkManeger = NetworkManeger()

    let titleTextColorAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    let movie = "movie"
    let tv = "tv"
    @IBOutlet weak var segmentController: UISegmentedControl!
   
    @IBOutlet weak var collectinView: UICollectionView!
    
    
    var arrayMovie: [Media] = []
    var arrayTv: [Media] = []
    var courencArray: [Media] = []
    var genresCollection: [Genres] = []
    
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectinView.dataSource = self
        collectinView.delegate = self
        collectinView.prefetchDataSource = self
        collectinView.isPrefetchingEnabled = false
        collectinView.isPrefetchingEnabled = true
        segmentControllerSetDiffoldValue()
    }
    
    @IBAction func segmentControllerAction(_ sender: Any) {
        if segmentController.selectedSegmentIndex == 0 {
            if arrayMovie.isEmpty {
               loadMediaDataFrom(name: movie)
            } else {
                courencArray = arrayMovie
                collectinView.reloadData()
            }
         
        } else if segmentController.selectedSegmentIndex == 1 {
            if arrayTv.isEmpty {
               loadMediaDataFrom(name: tv)
            } else {
                courencArray = arrayTv
                collectinView.reloadData()
            }
        }
    }
    
    private func loadMediaDataFrom(name: String) {
        Task.init {
            let mediaModel = try await networkManeger.loadMediaData(from: name)
            genresCollection = try await networkManeger.loadGenreData(from: name)
            if mediaModel.results[0].mediaType == movie {
                arrayMovie.append(mediaModel)
                courencArray = arrayMovie
                collectinView.reloadData()
            } else {
                arrayTv.append(mediaModel)
                courencArray = arrayTv
                collectinView.reloadData()
            }
        }
        
    }
 
    
    private func segmentControllerSetDiffoldValue() {
        segmentController.setTitleTextAttributes(titleTextColorAttributes, for: .selected)
        if segmentController.selectedSegmentIndex == 0 {
           loadMediaDataFrom(name: movie)
        }
    }
}


// MARK: Extension to CollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        courencArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        courencArray[section].results.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell",for: indexPath)
        guard let myCell = cell as? MovieCollectionViewCell else {return UICollectionViewCell()}
        
        let products = courencArray[indexPath.section].results
        let product = products[indexPath.row]
        myCell.media = product
        myCell.definitionGenreName(from: genresCollection, product: product)
    
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderReusableView", for: indexPath) as? HeaderReusableView else {return UICollectionReusableView()}

        view.nameSectioLabel.text = "Page \(courencArray[indexPath.section].page)"
        
        return view
    }
    
}



//MARK: Extension to CollectionVoewDeledat
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let ditailsVc = storyboard?.instantiateViewController(withIdentifier: "MoreDatailsViewController") as? DatailsViewController
        else {return}
        let sectionOfMedia = courencArray[indexPath.section]
        let selectedMedia = sectionOfMedia.results[indexPath.item]
        ditailsVc.genres = genresCollection
        ditailsVc.media = selectedMedia
        
        navigationController?.pushViewController(ditailsVc, animated: true)
    }
}

//MARK: Extension  to UICollectionViewDataSourcePrefetching

extension HomeViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath]) {
   
        let indicces = indexPaths.map { $0.row }
        let pageMovie = arrayMovie.count
        if indicces[1] == 15 {
            if segmentController.selectedSegmentIndex == 0 && pageMovie < 5 {
                Task.init {
                    let media = try await networkManeger.loadNextPage(from: movie,
                                                                      page: pageMovie + 1)
                    arrayMovie.append(media)
                    courencArray = arrayMovie
                    collectionView.reloadData()
                }
            } else if segmentController.selectedSegmentIndex == 1 && pageMovie < 5 {
                Task.init {
                    let media = try await networkManeger.loadNextPage(from: tv,
                                                                      page: pageMovie + 1)
                    arrayTv.append(media)
                    courencArray = arrayTv
                    collectionView.reloadData()
                }
            }
        }
       
            print("prefetch -  \(indicces)")
        

    }
    func collectionView(_ collectionView: UICollectionView,
                        cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        if indexPaths.last != nil {
            print("prefetch ")
        }
    }
    



}
