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
	static let cellSize: CGFloat = 500
	
	private var items = [TodayItem]()
	private var activitityIndicatorView: UIActivityIndicatorView = {
		let aiv = UIActivityIndicatorView(style: .whiteLarge)
		aiv.color = .darkGray
		aiv.startAnimating()
		aiv.hidesWhenStopped = true
		
		return aiv
	}()
	
	private var startingFrame: CGRect?
	private var appFullScreenController: TodayCellFullScreenController!
	
	private var topConstraint: NSLayoutConstraint?
	private var leadingConstraint: NSLayoutConstraint?
	private var widthConstraint: NSLayoutConstraint?
	private var heightConstraint: NSLayoutConstraint?
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Activity Indicator
		view.addSubview(activitityIndicatorView)
		activitityIndicatorView.centerInSuperview()
		
		// Fetch Data
		fetchData()
		
		navigationController?.isNavigationBarHidden = true
		collectionView?.backgroundColor = #colorLiteral(red: 0.9534369111, green: 0.9458779693, blue: 0.9529135823, alpha: 1)
		collectionView?.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
		collectionView.register(TodayAppListCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
	}
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cellId = items[indexPath.item].cellType.rawValue
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
		
		cell.todayItem = items[indexPath.item]
		
		return cell
	}
	
	//MARK:- Network
	
	private func fetchData() {
		let dispatchGroup = DispatchGroup()
		var topGrossing: AppCategory?
		var topGames: AppCategory?
		
		dispatchGroup.enter()
		APIService.shared.fetchGames { (appCategory, error) in
			dispatchGroup.leave()
			if let error = error {
				print("Failed to fetch games: ", error)
				return
			}
			
			topGames = appCategory
			
			
		}//END APIService
	
		dispatchGroup.enter()
		APIService.shared.fetchTopGrossing { (appCategory, error) in
			dispatchGroup.leave()
			if let error = error {
				print("Failed to fetch top-grossing: ", error)
				return
			}
			
			topGrossing = appCategory
		}//END APIService
		
		
		// Completion Block
		dispatchGroup.notify(queue: .main) {
			print("Finished fetching today data")
			self.activitityIndicatorView.stopAnimating()
			
			self.items = [
				TodayItem.init(category: "THE DAILY LIST", title: topGrossing?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossing?.feed.results ?? []),
				TodayItem.init(category: "THE DAILY LIST", title: topGames?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGames?.feed.results ?? []),
				TodayItem.init(category: "Life Hack", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps your need to intelligently organize your life the right way", backgroundColor: .white, cellType: .single, apps: [])
			]
			
			self.collectionView.reloadData()
		}
	}
	
	
	//MARK:- Collection View Selection
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if items[indexPath.item].cellType == .multiple {
			let fullController = TodayAppListController(mode: .fullScreen)
			fullController.results = self.items[indexPath.item].apps
			present(fullController, animated: true)
			return
		}
		
		let fullScreenController = TodayCellFullScreenController()
		fullScreenController.todayItem = items[indexPath.row]
		
		let fullscreenView  = fullScreenController.view!
		
		fullScreenController.dismissHandler = {
			self.handleRemoveEnlargedView()
		}

		view.addSubview(fullscreenView)
		
		addChild(fullScreenController)
		self.appFullScreenController = fullScreenController
		
		self.collectionView.isUserInteractionEnabled = false
		
		
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
			
			guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? TodayFullScreenHeaderCell else { return }
			cell.todayCell.topConsraint.constant = 48
			cell.layoutIfNeeded()
			
			
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
			
			guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? TodayFullScreenHeaderCell else { return }
			cell.todayCell.topConsraint.constant = 24
			cell.layoutIfNeeded()
			
		}, completion: { _ in
			self.appFullScreenController.view.removeFromSuperview()
			self.appFullScreenController.removeFromParent()
			self.collectionView.isUserInteractionEnabled = true
		})
	}
	
} //END TodayController

//MARK:- Collection View Layout
extension TodayController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width - 48, height: TodayController.cellSize)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 32
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 32, left: 0, bottom: 32, right: 0)
	}
	
}
