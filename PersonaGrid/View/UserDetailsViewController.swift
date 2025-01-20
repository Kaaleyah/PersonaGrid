//
//  UserDetailsViewController.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

import UIKit

class UserDetailsViewController: UIViewController {
    // USer object to be displayed
    private let user: User
    
    // UI elements to display user details
    private let nameLabel = UILabel()
    private let userNameLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let websiteLabel = UILabel()
    
    // Initializer for injecting the user object
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.name // Title of navigation bar
        applyDefaultBackgroundColor() // Default background
        setupUI()
    }
    
    // Set up user interface to display user details
    private func setupUI() {
        navigationController?.navigationBar.tintColor = .title
        
        // Name label with bold font
        nameLabel.text = "Name: \(user.name)"
        nameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        nameLabel.textColor = .title
        nameLabel.numberOfLines = 0 // Allow multiple lines
        nameLabel.lineBreakMode = .byWordWrapping // Wrap text at word boundaries
        
        // Username label with italic font
        userNameLabel.text = "Username: \(user.username)"
        userNameLabel.font = UIFont.italicSystemFont(ofSize: 24)
        userNameLabel.textColor = .title
        
        // Email label with semibold font
        emailLabel.text = "Email: \(user.email.lowercased())"
        emailLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        emailLabel.textColor = .text
        
        // Phone label with monospaced font
        phoneLabel.text = "Phone: \(user.phone)"
        phoneLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .regular)
        phoneLabel.textColor = .text
        
        // Website label with underlined text
        let websiteAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        websiteLabel.attributedText = NSAttributedString(string: user.website, attributes: websiteAttributes)
        websiteLabel.textColor = .text
        
        // Stack view to arrange all labels vertically
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            userNameLabel,
            emailLabel,
            phoneLabel,
            websiteLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // Center view and add paddings with Layout constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}
