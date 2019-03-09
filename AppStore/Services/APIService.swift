//
//  APIService.swift
//  AppStore
//
//  Created by Jony Tucci on 3/8/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import Foundation

class APIService {
	
	
	static let shared = APIService()
	
	func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
		
		let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			
			if let error = error {
				print("Failed to fetch apps:", error)
				completion([], error)
				return
			}
			
			guard let data = data else { return }
			
			do {
				let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
				completion(searchResult.results, nil)
			} catch let jsonErr{
				print("Failed to decode json: ", jsonErr)
				completion([], jsonErr)
			}
		}.resume()
	}
	
	func fetchGames(completion: @escaping (AppCategory?	, Error?) -> ()) {
		
		guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/non-explicit.json") else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error {
				print("Failed to fetch apps:", error)
				completion(nil, error)
				return
			}
			
			guard let data = data else { return }
			
			do {
				let appCategoryResult = try JSONDecoder().decode(AppCategory.self, from: data)
				completion(appCategoryResult, nil)
			} catch let jsonErr{
				print("Failed to decode json: ", jsonErr)
				completion(nil, jsonErr)
			}
		}.resume() //END URLSession
		
	} // END fetchGames
}
