//
//  TodayAppListController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/18/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TodayAppListController: BaseCollectionViewController {
	
	//MARK:- Properties
	enum Mode {
		case small, fullScreen
	}
	var results = [FeedResult]()
	private let todayAppCellId = "appCellId"
	private let spacing: CGFloat = 16
	private let mode: Mode	
	private let closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
		button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
		return button
	}()
	
	override var prefersStatusBarHidden: Bool { return true }
	
	//MARK:- Initialization
	init(mode: Mode) {
		self.mode = mode
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.backgroundColor = .white
		collectionView.register(TodayAppCell.self, forCellWithReuseIdentifier: todayAppCellId)
		
		if mode == .fullScreen {
			view.addSubview(closeButton)
			closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
			navigationController?.isNavigationBarHidden = true
		} else {
			collectionView.isScrollEnabled = false
		}

	}
	
	//MARK:- Handlers
	
	@objc private func handleDismiss() {
		dismiss(animated: true)
	}
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if mode == .fullScreen {
			return results.count
		}
		
		return min(4, results.count)
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayAppCellId, for: indexPath) as! TodayAppCell
		cell.app = results[indexPath.item]
		return cell
	}
	
	//MARK:- Collection View Selection
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let appId = self.results[indexPath.item].id
		let appDetailController = AppDetailController(appId: appId)
		navigationController?.pushViewController(appDetailController, animated: true)
	}
	
}

//MARK:- Collection View Layout
extension TodayAppListController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let height: CGFloat = 68
		let width: CGFloat
		
		if mode == .fullScreen {
			width = view.frame.width - 48
		} else {
			width = view.frame.width
		}
		
		return CGSize(width: width, height: height)
		
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return spacing
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		if mode == .fullScreen {
			return .init(top: 12, left: 24, bottom: 12, right: 24)
		}
		return .zero
	}
}
