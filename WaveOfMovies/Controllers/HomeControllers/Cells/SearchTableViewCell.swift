//
//  SearchTableViewCell.swift
//  WaveOfMovies
//
//  Created by Bohdan on 6/30/23.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNameLabel()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 23)
        nameLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: 8),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
        
    }
    
}
