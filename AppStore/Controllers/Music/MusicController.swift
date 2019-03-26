//
//  MusicController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/25/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class MusicController: BaseCollectionViewController {
	
	//MARK:- Properties
	private let trackCellId = "trackCellId"
	private let footerId = "footerId"
	private var results = [Result]()
	private let searchTerm = "taylor"
	private var isPaginating = false
	private var isDonePaginating = false
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.backgroundColor = .white
		
		collectionView.register(TrackCell.self, forCellWithReuseIdentifier: trackCellId)
		collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
		
		
		fetchData()
	}
	
	
	//MARK:- Network
	private func fetchData() {
		let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
		
		APIService.shared.fetch(urlString: urlString) { (searchResult: SearchResult?, error) in
			if let error = error {
				print("Failed to detch data: ", error)
				return
			}
			
			self.results = searchResult?.results ?? []
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return results.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trackCellId, for: indexPath) as! TrackCell
		let track = results[indexPath.item]
		
		cell.nameLabel.text = track.trackName
		cell.imageView.sd_setImage(with: URL(string: track.artworkUrl100))
		cell.subtitleLabel.text = "\(track.artistName ?? "") • \(track.collectionName ?? "")"
		if indexPath.item == results.count - 1 && !isPaginating {
			
			isPaginating = true
			
			let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
			
			APIService.shared.fetch(urlString: urlString) { (searchResult: SearchResult?, error) in
				if let error = error {
					print("Failed to detch data: ", error)
					return
				}
				
				if searchResult?.resultCount == 0 {
					self.isPaginating = true
				}
				
				self.results += searchResult?.results ?? []
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
				self.isPaginating = false
			}
		}
		
		return cell
	}
	
	//MARK:- Collection View Footer
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
		
		return footer
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return .init(width: view.frame.width, height: 100)
	}
}

//MARK:- Collection View Layout
extension MusicController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let height: CGFloat = isDonePaginating ? 0 : 100
		return CGSize(width: view.frame.width, height: height)
	}
	
	
}
