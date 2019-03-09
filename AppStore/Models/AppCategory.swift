//
//  AppCategory.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import Foundation

struct AppCategory: Codable {
	
	let feed: Feed
}

struct Feed: Codable {
	let title: String
	let results: [FeedResult]
}

struct FeedResult: Codable {
	let name: String
	let artistName: String
	let artworkUrl100: String 
}
