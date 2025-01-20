//
//  NetworkManagerTests.swift
//  PersonaGrid
//
//  Created by Furkan Can Baytemur on 20.01.2025.
//

import XCTest
@testable import PersonaGrid

class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    // Test: Successful fetch
    func testFetchDataSuccess() {
        let expectation = self.expectation(description: "Network request success")
        
        networkManager.fetchData(from: UserRepository.urlString) { result in
            switch result {
            case .success(let users):
                XCTAssertTrue(users.count > 0, "Should have fetched at least one user")
            case .failure(let error):
                XCTFail("Expected success but got error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Test: Network error
    func testFetchDataNetworkError() {
        let expectation = self.expectation(description: "Network request failure")
        
        networkManager.fetchData(from: "invalid-url") { result in
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
    
    // Test: Decoding error
    func testFetchDataDecodingError() {
        // Mock a URL that returns invalid data for the expected format
        let expectation = self.expectation(description: "Decoding error")
        
        networkManager.fetchData(from: "https://jsonplaceholder.typicode.com/invalid-data") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertTrue(error is NetworkError, "Error should be of type NetworkError")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
