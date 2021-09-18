//
//  BooksLibraryTests.swift
//  BooksLibraryTests
//
//  Created by Fatma Mohamed on 15/09/2021.
//



import XCTest
@testable import BooksLibrary

class BooksLibraryTests: XCTestCase {
//test retreiving books data
    var urlSession: URLSession!
    
    func testGetBooks() throws {
        let viewModel = BookViewModel()
        let mockSearch = "the lord of the rings"
        viewModel.getBooksData(searchQuery: mockSearch, completion: { result, error in
            XCTAssertEqual(result?.docs.count, 487)
        })
    }
    

    func testValidText() throws {
        let viewModel = BookViewModel()
        let mockSearchInv = "  "
        let mockSearchVal = "lord"
        XCTAssertEqual(viewModel.validateSearch(search: mockSearchInv), false)
        XCTAssertEqual(viewModel.validateSearch(search: mockSearchVal), true)
    }
    
    override func setUpWithError() throws {
                let urlSessionConfiguration = URLSessionConfiguration.ephemeral
                urlSessionConfiguration.protocolClasses = [MockURLProtocol.self]
               urlSession = URLSession(configuration: urlSessionConfiguration)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
