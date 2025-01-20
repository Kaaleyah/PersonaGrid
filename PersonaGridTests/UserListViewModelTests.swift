//
//  UserListViewModel.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

import XCTest
@testable import PersonaGrid

class UserListViewModelTests: XCTestCase {
    
    var viewModel: UserListViewModel!
    var mockUserRepository: MockUserRepository!
    
    override func setUp() {
        super.setUp()
        mockUserRepository = MockUserRepository()
        viewModel = UserListViewModel(userRepository: mockUserRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUserRepository = nil
        super.tearDown()
    }
    
    // Test: Successful fetch of users
    func testFetchUsersSuccess() {
        let expectation = self.expectation(description: "User list fetch success")
        
        mockUserRepository.shouldReturnSuccess = true
        
        viewModel.fetchUserListFromRepo()
        
        // Wait for the view model to update
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.userList.count, 1, "Should fetch 1 user")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    // Test: Error handling in fetching users
    func testFetchUsersFailure() {
        let expectation = self.expectation(description: "User list fetch failure")
        
        mockUserRepository.shouldReturnSuccess = false
        
        viewModel.fetchUserListFromRepo()
        
        // Wait for the error message to update
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.errorMessage, "Error message should be set")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    class MockUserRepository: UserRepository {
        var shouldReturnSuccess: Bool = false
        
        override func fetchUserList(completion: @escaping (Result<[User], Error>) -> Void) {
            if shouldReturnSuccess {
                completion(.success([User(id: 1, name: "John", username: "john_doe", email: "john@example.com", phone: "123456789", website: "john.com")]))
            } else {
                completion(.failure(NetworkError.noData))
            }
        }
    }
}


