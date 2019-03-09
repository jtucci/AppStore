//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
	
	
	//MARK:- Properties
	let titleLabel = UILabel(text: "Add Section", font: .boldSystemFont(ofSize: 30))

	let horizontalController = AppsHorizontalController()
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		 backgroundColor = .lightGray
		
		
		setupCellLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Setup
	private func setupCellLayout() {
		
		
		addSubview(titleLabel)
		titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
		addSubview(horizontalController.view)
		horizontalController.view.backgroundColor = .blue
		horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
	}
}

extension UILabel {
	
	convenience init(text: String, font: UIFont) {
		self.init(frame: .zero)
		self.text = text
		self.font = font
	}
	
}
