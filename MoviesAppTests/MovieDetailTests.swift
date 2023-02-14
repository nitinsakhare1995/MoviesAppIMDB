//
//  MovieDetailTests.swift
//  MoviesAppTests
//
//  Created by Nitin Sakhare on 14/02/23.
//

import XCTest
@testable import MoviesApp

final class MovieDetailTests: XCTestCase {

    var sut: MovieDetailViewModel?
    
    var mockAPIServiceMovieDetail: MockAPIServiceMovieDetail!

    override func setUp() {
        super.setUp()
        sut = MovieDetailViewModel()
        
        mockAPIServiceMovieDetail = MockAPIServiceMovieDetail()
        sut = MovieDetailViewModel(apiService: mockAPIServiceMovieDetail)
    }
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testMovieDetail() {
        
        let sut = self.sut!
        
        let expect = XCTestExpectation(description: "movieDetailCallBack")
        
        sut.fetchMovieDetails(movieId: "1223") { dataObject in
            expect.fulfill()
            XCTAssertNotEqual( dataObject.value?.overview, "")
        }
        
        wait(for: [expect], timeout: 1)
    }

}
