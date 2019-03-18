//
//  TodayAppCell .swift
//  AppStore
//
//  Created by Jony Tucci on 3/18/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

// * SAME AS AppCell from Apps Main Page, need to refactor
class TodayAppCell: UICollectionViewCell {
	
	//MARK:- Properties
	let imageView: UIImageView = UIImageView(cornerRadius: 8)
	let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
	let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
	let getButton = UIButton(title: "GET")
	
	let seperatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(white: 0.4, alpha: 0.3)
		return view
	}()
	
	var app: FeedResult! {
		didSet{
			nameLabel.text = app.name
			companyLabel.text = app.artistName
			imageView.sd_setImage(with: URL(string: app.artworkUrl100))
		}
	}
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupProperties()
		setupCellLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Setup
	private func setupProperties() {
		// Image view setup
		imageView.layer.borderWidth = 0.5
		imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
		imageView.clipsToBounds = true
		imageView.backgroundColor = .purple
		
		// Button Setup
		getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
		getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		getButton.layer.cornerRadius = 32 / 2
	}
	
	private func setupCellLayout() {
		imageView.constrainWidth(constant: 64)
		imageView.constrainHeight(constant: 64)
		
		getButton.constrainWidth(constant: 80)
		getButton.constrainHeight(constant: 32)
		
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
		
		addSubview(seperatorView)
		seperatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0), size: .init(width: 0, height: 0.5))
	}
	
}
