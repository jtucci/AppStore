//
//  AppRowCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
	
	
	//MARK:- Properties
	let imageView: UIImageView = UIImageView(cornerRadius: 8)
	let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
	let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
	let getButton = UIButton(title: "GET")
	
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
		
		imageView.backgroundColor = .purple
		imageView.constrainWidth(constant: 64)
		imageView.constrainHeight(constant: 64)
		
		getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
		getButton.constrainWidth(constant: 80)
		getButton.constrainHeight(constant: 32)
		getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		getButton.layer.cornerRadius = 32 / 2
		
		// LABELS STACK VIEW
		let labelStackView = UIStackView(arrangedSubviews: [
			nameLabel, companyLabel
			])
		labelStackView.axis = .vertical
		labelStackView.spacing = 4
		
		// ROOT STACK VIEW (contains all)
		let rootStackView = UIStackView(arrangedSubviews: [
			imageView, labelStackView, getButton
		])
		
		rootStackView.spacing = 16
		rootStackView.alignment = .center
		addSubview(rootStackView)
		rootStackView.fillSuperview()
	}
}
