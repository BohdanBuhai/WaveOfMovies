//
//  FavoritTableViewCell.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/20/23.
//

import UIKit

class FavoritTableViewCell: UITableViewCell {

    let posterImage = UIImageView()
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupImage()
        setupNameLabel()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImage() {
        
        contentView.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        
        posterImage.clipsToBounds = true
        NSLayoutConstraint.activate([
            posterImage.widthAnchor.constraint(equalToConstant: contentView.frame.height ),
            posterImage.heightAnchor.constraint(equalToConstant: contentView.frame.height ),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
        posterImage.layer.cornerRadius = posterImage.frame.width / 2
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        nameLabel.textColor = UIColor.white
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    
}
