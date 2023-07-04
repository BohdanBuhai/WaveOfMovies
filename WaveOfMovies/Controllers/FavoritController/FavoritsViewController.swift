//
//  FavoritsViewController.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/13/23.
//

import UIKit

class FavoritsViewController: UIViewController {

    let tableView = UITableView()
    let userDefaults = UserDefaultsManager()
    var data: [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        print("viewWillAppear")
    }
    
    private func loadData() {
        Task.init {
            do {
                data = try await userDefaults.loadFromUD()
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = 48
        tableView.register(FavoritTableViewCell.self, forCellReuseIdentifier: "MyCell")
    }

}

//MARK: Extension

extension FavoritsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? FavoritTableViewCell else {return cell}
        let media = data[indexPath.item]
        myCell.backgroundColor = .clear
        myCell.nameLabel.text = media.title ?? media.name
        
        return myCell
    }
}

extension FavoritsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let ditailsVc = storyboard?.instantiateViewController(withIdentifier: "DatailsViewController") as? DatailsViewController
        else {return}
        let selectedMedia = data[indexPath.item]
//        ditailsVc.genres = genresCollection
        ditailsVc.media = selectedMedia
        
        navigationController?.pushViewController(ditailsVc, animated: true)
    }
    
}
