//
//  PreviewScreenShotsHorizontalController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/13/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

final class PreviewScreenShotsHorizontalController: HorizontalSnappingCollectionViewController {
	
	//MARK:- Properties
	let screenShotCellId = "screenShotCell"
	var app: Result? {
		didSet {
			collectionView?.reloadData()
		}
	}
	
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCollectionView()
	}
	
	//MARK:- Setup
	private func setupCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.register(ScreenShotCell.self, forCellWithReuseIdentifier: screenShotCellId)
		collectionView?.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
	}
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return app?.screenshotUrls!.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenShotCellId, for: indexPath) as! ScreenShotCell
		let screenShotUrl = self.app?.screenshotUrls![indexPath.item] ?? ""
		cell.imageView.sd_setImage(with: URL(string: screenShotUrl) )
		return cell
	}
	
}

//MARK:- Collection View Layout
extension PreviewScreenShotsHorizontalController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: 250, height: view.frame.height)
		
	}
	
}

