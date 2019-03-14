//
//  AppSearchController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/8/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit
import SDWebImage

class AppSearchController: BaseCollectionViewController {

	
	//MARK:- Properties
	private let cellId = "cell"
	private var appResults = [Result]()
	private let searchController = UISearchController(searchResultsController: nil)
	private var timer: Timer? // Used to throttle search results when typing
	
	//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		collectionView?.backgroundColor = .white
		collectionView?.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
		
		setupSearchBar()
    }
	
	
	//MARK:- Setup
	private func setupSearchBar() {
		definesPresentationContext = true
		navigationItem.searchController = self.searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchBar.delegate = self
	}
	
	
	//MARK:- Collection View Delegate
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
		let appResult = appResults[indexPath.item]
		cell.appResult = appResult

		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return appResults.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let appId = String(appResults[indexPath.item].trackId)
		let appDetailController = AppDetailController(appId: appId)
		navigationController?.pushViewController(appDetailController, animated: true)
	}
}

//MARK:- Collection View Flow Layout Delegate
extension AppSearchController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width, height: 300)
		
	}
	
}

//MARK:- Search Bar Delegate
extension AppSearchController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		// Throttles api calls to wait until user finishes typing
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
			
			APIService.shared.fetchApps(searchTerm: searchText) { (results, error) in
				
				if let error = error {
					print("Failed to fetch apps in search page: ", error)
					return
				}
				
				self.appResults = results?.results ?? []
				DispatchQueue.main.async {
					self.collectionView?.reloadData()
				}
				
			} // END APIService
		}) // END Timer
		
	}
}
