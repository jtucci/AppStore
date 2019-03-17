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
	private var appFullScreenController: TodayCellFullScreenController!
	
	private var topConstraint: NSLayoutConstraint?
	private var leadingConstraint: NSLayoutConstraint?
	private var widthConstraint: NSLayoutConstraint?
	private var heightConstraint: NSLayoutConstraint?
	
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
		
		let fullScreenController = TodayCellFullScreenController()
		let fullscreenView  = fullScreenController.view!
		
		fullScreenController.dismissHandler = {
			self.handleRemoveEnlargedView()
		}

		view.addSubview(fullscreenView)
		
		addChild(fullScreenController)
		self.appFullScreenController = fullScreenController
		
		
		
		
		// absolute coordinates of cell
		guard let cell = collectionView.cellForItem(at: indexPath) else { return }
		guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
		self.startingFrame = startingFrame
		
		//AutoLayout constraint animations
		fullscreenView.translatesAutoresizingMaskIntoConstraints = false
		topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
		leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
		widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
		heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
		
		[topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
		self.view.layoutIfNeeded()
		
		fullscreenView.layer.cornerRadius = 16
		
		
		
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

			
			self.topConstraint?.constant = 0
			self.leadingConstraint?.constant = 0
			self.widthConstraint?.constant = self.view.frame.width
			self.heightConstraint?.constant = self.view.frame.height
		
			
			self.view.layoutIfNeeded() // starts animation
			
			self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
		}, completion: nil)
	}
	
	@objc private func handleRemoveEnlargedView() {
		
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
			
			self.appFullScreenController.tableView.contentOffset = .zero
			guard let startingFrame = self.startingFrame else { return }
			
			self.topConstraint?.constant = startingFrame.origin.y
			self.leadingConstraint?.constant = startingFrame.origin.x
			self.widthConstraint?.constant = startingFrame.width
			self.heightConstraint?.constant = startingFrame.height
			
			self.view.layoutIfNeeded() // starts animation
			
			self.tabBarController?.tabBar.transform = .identity
			
			
		}, completion: { _ in
			self.appFullScreenController.view.removeFromSuperview()
			self.appFullScreenController.removeFromParent()
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
