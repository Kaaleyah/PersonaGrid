//
//  UserRepositoryTests.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

import XCTest
@testable import PersonaGrid

class UserRepositoryTests: XCTestCase {
    
    var userRepository: UserRepository!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        userRepository = UserRepository(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        userRepository = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    // Test: Fetch user list success
    func testFetchUserListSuccess() {
        let expectation = self.expectation(description: "Fetch user list success")
        
        mockNetworkManager.shouldReturnSuccess = true
        
        userRepository.fetchUserList { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1, "Should return exactly 1 user")
            case .failure:
                XCTFail("Expected success but got error")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Test: Fetch user list failure
    func testFetchUserListFailure() {
        let expectation = self.expectation(description: "Fetch user list failure")
        
        mockNetworkManager.shouldReturnSuccess = false
        
        userRepository.fetchUserList { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error, "Should return an error")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    class MockNetworkManager: NetworkManager {
        var shouldReturnSuccess: Bool = false
        
        override func fetchData(from url: String, completion: @escaping (Result<[User], Error>) -> Void) {
            if shouldReturnSuccess {
                completion(.success([User(id: 1, name: "John", username: "john_doe", email: "john@example.com", phone: "123456789", website: "john.com")]))
            } else {
                completion(.failure(NetworkError.noData))
            }
        }
    }
}
