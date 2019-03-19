//
//  TodayAppListCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/18/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TodayAppListCell: BaseTodayCell {
	

	//MARK:- Properties
	let appListController = TodayAppListController(mode: .small)
	let categoryLabel = UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 20))
	let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
	
	override var todayItem: TodayItem! {
		didSet {
			categoryLabel.text = todayItem.category
			titleLabel.text = todayItem.title
			appListController.results = todayItem.apps
			appListController.collectionView.reloadData()
		}
	}
	
	
	//MARK:- Initialziation
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .white
		layer.cornerRadius = 16
		
		let stackView = UIStackView(arrangedSubviews: [
			categoryLabel,
			titleLabel,
			appListController.view
		])
		stackView.axis = .vertical
		stackView.spacing = 12
		
		addSubview(stackView)
		stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
