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
	
	private var anchoredConstraints: AnchoredConstraints?
	
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.superview?.setNeedsLayout()
	}
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cellId = items[indexPath.item].cellType.rawValue
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
		
		cell.todayItem = items[indexPath.item]
		
		(cell as? TodayAppListCell)?.appListController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAppsTap)))
		return cell
	}
	
	
	//MARK:- Collection View Selection
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		switch items[indexPath.item].cellType {
		case .multiple:
			showDailyListFullScreen(indexPath)
		case .single:
			showSingleAppFullscreen(indexPath: indexPath)
		}
	}
	
	// MARK:- Handlers
	@objc private func handleRemoveEnlargedView() {
		
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
			
			self.appFullScreenController.tableView.contentOffset = .zero
			guard let startingFrame = self.startingFrame else { return }
			
			self.anchoredConstraints?.top?.constant = startingFrame.origin.y
			self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
			self.anchoredConstraints?.width?.constant = startingFrame.width
			self.anchoredConstraints?.height?.constant = startingFrame.height
			
			self.view.layoutIfNeeded() // starts animation
			
			self.tabBarController?.tabBar.transform = .identity
			
			guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? TodayFullScreenHeaderCell else { return }
			self.appFullScreenController.closeButton.alpha = 0
			cell.todayCell.topConsraint.constant = 24
			cell.layoutIfNeeded()
			
		}, completion: { _ in
			self.appFullScreenController.view.removeFromSuperview()
			self.appFullScreenController.removeFromParent()
			self.collectionView.isUserInteractionEnabled = true
		})
	}
	
	@objc private func handleAppsTap(gesture: UIGestureRecognizer) {
		
		let collectionView = gesture.view
		let fullController = TodayAppListController(mode: .fullScreen)
		var superview = collectionView?.superview
		
		while superview != nil {
			if let cell = superview as? TodayAppListCell {
				
				guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
				let apps = self.items[indexPath.item].apps
				
				fullController.results = apps
				present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
				return
			}
			superview = superview?.superview
		}

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
				TodayItem.init(category: "Life Hack", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps your need to intelligently organize your life the right way", backgroundColor: .white, cellType: .single, apps: []),
				TodayItem.init(category: "THE DAILY LIST", title: topGrossing?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossing?.feed.results ?? []),
				TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, apps: []),
				TodayItem.init(category: "THE DAILY LIST", title: topGames?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGames?.feed.results ?? [])
			]
			
			self.collectionView.reloadData()
		}
	}
	
	//MARK:- Helper Functions
	
	private func showDailyListFullScreen(_ indexPath: IndexPath) {
		let fullController = TodayAppListController(mode: .fullScreen)
		fullController.results = self.items[indexPath.item].apps
		present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
		
	}
	
	private func showSingleAppFullscreen(indexPath: IndexPath) {
		setupSingleAppFullScreenController(indexPath)
		setupAppFullScreenStartingPostion(indexPath)
		beginAnimationAppFullscreen()
	}
	
	
	//MARK:- Helper Functions Setup
	private func setupSingleAppFullScreenController(_ indexPath: IndexPath) {
		let fullScreenController = TodayCellFullScreenController()
		fullScreenController.todayItem = items[indexPath.row]
		fullScreenController.dismissHandler = {
			self.handleRemoveEnlargedView()
		}
		fullScreenController.view.layer.cornerRadius = 16
		self.appFullScreenController = fullScreenController
	}
	
	private func setupAppFullScreenStartingPostion(_ indexPath: IndexPath) {
		let fullscreenView  = appFullScreenController.view!
		view.addSubview(fullscreenView)
		addChild(appFullScreenController)
		
		self.collectionView.isUserInteractionEnabled = false
		
		// absolute coordinates of cell
		setupStartingCellFrame(indexPath)
		guard let startingFrame = self.startingFrame else { return }
		
		//AutoLayout constraint animations
		self.anchoredConstraints = fullscreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
		
		self.view.layoutIfNeeded()
	}
	
	private func setupStartingCellFrame(_ indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) else { return }
		guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
		self.startingFrame = startingFrame
	}
	
	private func beginAnimationAppFullscreen() {
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
			
			self.anchoredConstraints?.top?.constant = 0
			self.anchoredConstraints?.leading?.constant = 0
			self.anchoredConstraints?.width?.constant = self.view.frame.width
			self.anchoredConstraints?.height?.constant = self.view.frame.height

			self.view.layoutIfNeeded() // starts animation
			self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
			guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0,0]) as? TodayFullScreenHeaderCell else { return }
			cell.todayCell.topConsraint.constant = 48
			cell.layoutIfNeeded()
		}, completion: nil)
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
