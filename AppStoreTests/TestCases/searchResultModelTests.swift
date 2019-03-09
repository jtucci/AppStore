//
//  searchResultModelTests.swift
//  AppStoreTests
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import XCTest
@testable import AppStore

class searchResultModelTests: XCTestCase {
	
	var searchResult: SearchResult!
	var instaResult: Result!
	
	//MARK:- Setup & TearDown
    override func setUp() {
        super.setUp()
		
		let data = loadStub(name: "instaSearch", extension: "json")
		let decoder = JSONDecoder()
		searchResult = try! decoder.decode(SearchResult.self, from: data)
		instaResult = searchResult.results[0]
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	
	//MARK:- Tests for App name
	func testAppName() {
		XCTAssertEqual(instaResult.trackName, "Instagram")
	}
	
	//MARK:- Tests for Genere Name
	func testPrimaryGenre() {
		XCTAssertEqual(instaResult.primaryGenreName, "Photo & Video")
	}
	
	//MARK:- Tests for User Ratings
	func testAverageUserRating() {
		XCTAssertEqual(instaResult.averageUserRating, 5)
	}
	
	//MARK:- Tests for images
	func testAppIcon() {
		let imageString = instaResult.artworkUrl100
		XCTAssertNotNil(imageString)
		
	}
    
}
