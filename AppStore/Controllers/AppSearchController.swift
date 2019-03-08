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
	
	
	//MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		collectionView?.backgroundColor = .white
		collectionView?.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
    }

	
	//MARK:- Initialization
	init() {
		super.init(collectionViewLayout: UICollectionViewFlowLayout())
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	//MARK:- Collection View Delegate
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}
	
}

//MARK:- Collection View Flow Layout Delegate
extension AppSearchController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width, height: 250)
		
	}
	
}
