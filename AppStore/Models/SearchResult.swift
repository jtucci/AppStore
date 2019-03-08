//
//  SearchResult.swift
//  AppStore
//
//  Created by Jony Tucci on 3/8/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
	
	let resultCount: Int
	let results: [Result]

}

struct Result: Codable {
	
	let trackName: String
	let primaryGenreName: String
	
	// Optional because not all apps have ratings
	var averageUserRating: Float?
}

