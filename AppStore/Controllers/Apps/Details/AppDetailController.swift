//
//  AppDetailController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/10/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit


class AppDetailController: BaseCollectionViewController {
	
	
	//MARK:- Properties
	let detailCellId = "AppDetailCell"
	
	var appId: String! {
		didSet {
			// appId set
			let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
			APIService.shared.fetch(urlString: urlString) { (result: SearchResult?, error) in
				
			}
		}
	}
	
	
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView?.backgroundColor = .white
		collectionView?.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
		navigationItem.largeTitleDisplayMode = .never
		
	}
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
		
		return cell 
	}
}

//MARK:- Collection View Layout
extension AppDetailController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: 300)
		
	}
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//		return 10
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//		return .init(top: 12, left: 16, bottom: 12, right: 16)
//	}
	
}

