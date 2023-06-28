//
//  SearchViewController.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/26/23.
//

import UIKit

class SearchViewController: UIViewController  {
   
    let searchController = UISearchController()
    let tabelView = UITableView()
    
    
    let home = HomeViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchTextField.textColor = .red
        navigationController?.navigationBar.isHidden = false
        setupTabelView()
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    private func setupTabelView() {
        view.addSubview(tabelView)
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    

 

}
//MARK: Search Results Updating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        print(text)
    }
}
