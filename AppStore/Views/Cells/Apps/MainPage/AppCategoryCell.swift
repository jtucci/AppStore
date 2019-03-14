//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

/// Contains a nested collection of app cells grouped by category
final class AppCategoryCell: UICollectionViewCell {
	
	//MARK:- Properties
	let titleLabel = UILabel(text: "Add Section", font: .boldSystemFont(ofSize: 30))
	let horizontalController = AppCategoryHorizontalController()
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCellLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Setup
	private func setupCellLayout() {
		addSubview(titleLabel)
		titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
		addSubview(horizontalController.view)
		horizontalController.view.backgroundColor = .blue
		horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
	}
}


