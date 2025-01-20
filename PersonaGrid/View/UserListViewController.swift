//
//  ViewController.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

import UIKit
import Combine

// View Controller to display list of users
class UserListViewController: UIViewController {
    // View model to manage user list and errors
    private let userViewModel = UserListViewModel()
    // Tablew view for list of users
    private let userTable = UITableView()
    // Set to manage Combine cancellables
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        setupTable()
        bindViewToModel()
        userViewModel.fetchUserListFromRepo()
    }
    
    // Set up UI elements, title, navigation bar
    private func setupUI() {
        // Main screen background color
        view.backgroundColor = .accent
        applyDefaultBackgroundColor()
        
        // Title of navigation bar
        self.title = "Persona Grid"
        
        // Configure title appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .accent
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.title, // Text color
            .font: UIFont.systemFont(ofSize: 18, weight: .bold) // Font
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // Bind data to viewmodel data
    private func bindViewToModel() {
        // Observe changes in user list and reload table
        userViewModel.$userList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.userTable.reloadData()
            }
            .store(in: &cancellables)
        
        // Observe errors and show them in alert dialogs
        userViewModel.$errorMessage
            .compactMap{ $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showError(error)
            }
            .store(in: &cancellables)
    }
    
    // Display error message in alert dialog
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "An error occurred", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
            self?.userViewModel.fetchUserListFromRepo()
            // Try again for fetching user list
        }))
        present(alert, animated: true)
    }
    
    // Set up table view with appropriate properties
    private func setupTable() {
        userTable.frame = view.bounds
        userTable.dataSource = self
        userTable.delegate = self
        userTable.register(UserCell.self, forCellReuseIdentifier: "UserCell") // Custom Cell view
        userTable.backgroundColor = .background
        view.addSubview(userTable)
    }
}

// MARK: Table Data Source
// Extension to handle data source methods
extension UserListViewController: UITableViewDataSource {
    // Return the number of rows in the table (number of users in the list)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userViewModel.userList.count
    }
    
    // Configure each cell with the user's data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue reusable cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            fatalError("UserCell not found")
        }
        
        // Get user from index and configure the cell with it
        let user = userViewModel.userList[indexPath.row]
        cell.configure(with: user)
        return cell
    }
}

// MARK: Table Delegate
// Extension to handle table delegate methods
extension UserListViewController: UITableViewDelegate {
    // Handle row selection by navigating to the user details screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = userViewModel.userList[indexPath.row]
        let detailsScreen = UserDetailsViewController(user: user)
        // Navigate to show user details
        navigationController?.pushViewController(detailsScreen, animated: true)
    }
}

// MARK: Global func for UIViewController
// Extension to add default background color application to all UIViewControllers
extension UIViewController {
    func applyDefaultBackgroundColor() {
        view.backgroundColor = .background
    }
}
