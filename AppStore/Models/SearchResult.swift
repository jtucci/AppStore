//
//  SearchResult.swift
//  AppStore
//
//  Created by Jony Tucci on 3/8/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import Foundation


struct SearchResult: Decodable {
	
	let resultCount: Int
	let results: [Result]

}

struct Result: Decodable {
	
	let trackName: String
	let primaryGenreName: String
	var averageUserRating: Float?	// Optional because not all apps have ratings
	let screenshotUrls: [String] 	// app screen shots
	let artworkUrl100: String 		// app icon
	let formattedPrice: String
	let description: String
	let releaseNotes: String 
	
}

