//
//  UserListViewModel.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

import Foundation
import Combine

// ViewModel for managing the user list and interaction with the UserRepository.
class UserListViewModel {
    // Repository that handles data fetching logic
    private let userRepository: UserRepository
    // Set to store Combine cancellables to manage the lifecycle of Combine subscriptions
    private var cancellables = Set<AnyCancellable>()
    
    // Published properties that update the view with changes
    @Published var userList: [User] = []
    @Published var errorMessage: String?
    
    // Default inializer with UserRepository
    init(userRepository: UserRepository = UserRepository()) {
        self.userRepository = userRepository
    }
    
    // Fetch the user list from the repository and update the view model
    func fetchUserListFromRepo() {
        userRepository.fetchUserList { [weak self] result in
            switch result {
            case .success(let fetchedUsers):
                DispatchQueue.main.async {
                    // On success, update the user list on the main thread
                    self?.userList = fetchedUsers
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    // On failure, set the error message to be displayed
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
