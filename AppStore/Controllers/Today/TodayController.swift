//
//  TodayController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/16/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TodayController: BaseCollectionViewController {
	
	//MARK:- properties
	private let todayCellId = "todayCellId"
	private var startingFrame: CGRect?
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.isNavigationBarHidden = true
		
		collectionView?.backgroundColor = #colorLiteral(red: 0.9534369111, green: 0.9458779693, blue: 0.9529135823, alpha: 1)
		collectionView?.register(TodayCell.self, forCellWithReuseIdentifier: todayCellId)
	}
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayCellId, for: indexPath) as! TodayCell
		
		return cell
	}
	
	//MARK:- Collection View Selection
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let redStubView = UIView()
		redStubView.backgroundColor = .red
		redStubView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
		view.addSubview(redStubView)
		
		guard let cell = collectionView.cellForItem(at: indexPath) else { return }
		
		// absolute coordinates of cell
		guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
		self.startingFrame = startingFrame
		redStubView.frame = startingFrame
		redStubView.layer.cornerRadius = 16
		
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
			redStubView.frame = self.view.frame
		}, completion: nil)
	}
	
	@objc private func handleRemoveRedView(gesture: UITapGestureRecognizer) {
		
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
			gesture.view?.frame = self.startingFrame ?? .zero
		}, completion: { _ in
			gesture.view?.removeFromSuperview()
		})
	}
	
} //END TodayController

//MARK:- Collection View Layout
extension TodayController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width - 48, height: 450)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 32
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 32, left: 0, bottom: 32, right: 0)
	}
	
}
