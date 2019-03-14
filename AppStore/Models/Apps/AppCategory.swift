//
//  AppCategory.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import Foundation

// Collection of apps grouped by category (Top-Free, Top-Grossing, Editors Picks, etc.. )
struct AppCategory: Decodable {
	let feed: Feed
}

struct Feed: Decodable {
	let title: String
	let results: [FeedResult]
}

struct FeedResult: Decodable {
	let id: String
	let name: String
	let artistName: String
	let artworkUrl100: String 
}
