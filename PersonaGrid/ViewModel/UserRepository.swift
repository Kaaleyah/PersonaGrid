//
//  UserRepository.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

// UserRepository handles the fetching of user data from the NetworkManager and manages error handling.
class UserRepository {
    private let networkManager: NetworkManager
    static let urlString = "https://jsonplaceholder.typicode.com/users"
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // Fetch user list by calling NetworkManager's fetchData method
    func fetchUserList(completion: @escaping (Result<[User], Error>) -> Void) {
        
        // Call the network manager to fetch data from the provided URL
        networkManager.fetchData(from: UserRepository.urlString) { result in
            switch result {
            case .success(let userList):
                // On success, print a message and return the user list to the completion handler
                print("Fetched user list")
                completion(.success(userList))
            case .failure(let error):
                // On failure, handle different error cases for better debugging and logging
                
                // Check if the error is a known NetworkError type and print errors accordingly
                if let networkError = error as? NetworkError {
                    switch networkError {
                    case .invalidURL:
                        print("Invalid URL")
                    case .noData:
                        print("No data received.")
                    case .decodingError:
                        print("Failed to decode data.")
                    case .unknown:
                        print("An unknown error occurred.")
                    }
                }
                else {
                    // If the error is not a NetworkError, print the localized error description
                    print("Error: \(error.localizedDescription)")
                }
                completion(.failure(error))
            }
        }
    }
}
