//
//  SearchViewController.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/26/23.
//

import UIKit

class SearchViewController: UIViewController  {
   
    let networkManager = NetworkManager()
    let searchController = UISearchController()
    let tableView = UITableView()
    var searchResults: [Results] = []
    var mediaType: String = "movie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearch()
        setupTabelView()
       
    }
    
    private func setupSearch() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchTextField.textColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTabelView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(SearchTableViewCell.self,
                           forCellReuseIdentifier: "\(SearchTableViewCell.self)")
        tableView.rowHeight = 50
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }

}
//MARK:  extension - Search Results Updating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        Task.init {
            do {
                searchResults = try await networkManager.loadSearch(text: text, media: mediaType)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
        print(text)
    }
}

//MARK: extension - TabelViewDataSourse

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchTableViewCell.self)",for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = searchResults[indexPath.item].title ?? searchResults[indexPath.item].name
        
        return cell
    }
}

//MARK: extansion - TabelViewDelegete
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let ditailsVc = storyboard?.instantiateViewController(withIdentifier: "DatailsViewController") as? DatailsViewController else {return}
        let media = searchResults[indexPath.item]
        
        ditailsVc.media = media
        navigationController?.pushViewController(ditailsVc, animated: true)
    }
}

