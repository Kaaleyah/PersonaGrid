//
//  NetworkManager.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

import Foundation

// NetworkManager is a singleton class responsible for handling network requests.
class NetworkManager {
    // Shared instance of the NetworkManager for accessing it throughout the app
    static let shared = NetworkManager()
    
    // Fetch data from the provided URL and return a list of users or an error.
    func fetchData(from url:  String, completion: @escaping (Result<[User], Error>) -> Void) {
        // Ensure URL string is a valid one
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Start network data task to fetch from API
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check if there was an error during network request
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Ensure data is received
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // Attempt to decode data to list of User objects
            do {
                // Use JSONDecoder to decode the data into an array of User objects
                let userList = try JSONDecoder().decode([User].self, from: data)
                completion(.success(userList))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}

// Enum for different types of network-related errors
enum NetworkError: Error {
    case invalidURL   // The provided URL was invalid
    case noData       // No data was returned in the response
    case decodingError  // An error occurred while decoding the data
    case unknown      // Any other unexpected error
}
