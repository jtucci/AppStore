//
//  AppSearchController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/8/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AppSearchController: UICollectionViewController {

	
	//MARK:- Properties
	private let cellId = "cell"
	private var appResults = [Result]()
	
	//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		collectionView?.backgroundColor = .white
		collectionView?.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
		
		fetchITunesApps()
    }

	
	//MARK:- Initialization
	init() {
		super.init(collectionViewLayout: UICollectionViewFlowLayout())
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: Network Call
	private func fetchITunesApps() {
		
		let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			
			if let error = error {
				print("Failed to fetch apps:", error)
				return
			}
			
			guard let data = data else { return }
			
			do {
				let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
				self.appResults = searchResult.results
				DispatchQueue.main.async {
					self.collectionView?.reloadData()
				}
				
			} catch let jsonErr{
				print("Failed to decode json: ", jsonErr)
			}
			
			
			
		}.resume()
	}
	
	//MARK:- Collection View Delegate
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
		let appResult = appResults[indexPath.item]
		
		cell.nameLabel.text = appResult.trackName
		cell.categoryLabel.text = appResult.primaryGenreName
		cell.ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return appResults.count
	}
	
}

//MARK:- Collection View Flow Layout Delegate
extension AppSearchController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width, height: 250)
		
	}
	
}
