//
//  UserCell\.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

import UIKit

// Custom UITableViewCell to display user info
class UserCell: UITableViewCell {
    // Labels to display user in table
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    
    // Custom initializer for creating cells
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up layout and appearance of cell and its subviews
    private func setupUI() {
        // Configure nameLabel: bold font and a distinct color for titles
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.textColor = .title
        
        // Configure emailLabel: regular font and a subtle color for secondary text
        emailLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        emailLabel.textColor = .text
        
        // Stack view to arrange labels vertically with spacing
        let stackView = UIStackView(arrangedSubviews: [nameLabel, emailLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        contentView.addSubview(stackView)
        contentView.backgroundColor = .background
        
        // Set up Auto Layout constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // Configure the cell with data from a User object
    func configure(with user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email.lowercased()
    }
}
