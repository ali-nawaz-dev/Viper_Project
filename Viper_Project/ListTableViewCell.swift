//
//  ListTableViewCell.swift
//  Viper_Project
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    // Add any other UI elements here
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configure the cell's UI elements
        contentView.addSubview(titleLabel)
        
        // Setup constraints for UI elements
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            // Add constraints for other UI elements if needed
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
