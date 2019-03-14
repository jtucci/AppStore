//
//  AppDetailCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/10/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

final class AppDetailCell: UICollectionViewCell {
	
	//MARK:- Properties
	let appIconImageView = UIImageView(cornerRadius: 16)
	let nameLabel = UILabel(text: "Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
	let priceButton = UIButton(title: "$4.99")
	let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
	let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
	 
	var app: Result! {
		didSet {
			nameLabel.text = app?.trackName
			releaseNotesLabel.text = app?.releaseNotes
			appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
			priceButton.setTitle(app?.formattedPrice, for: .normal)
		}
	}
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupProperties()
		setupLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:-Setup
	private func setupProperties() {
		//Icon Setup
		appIconImageView.layer.borderWidth = 0.5
		appIconImageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
		appIconImageView.clipsToBounds = true
		// Button Setup
		priceButton.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.4588235294, blue: 0.9529411765, alpha: 1)
		priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		priceButton.setTitleColor(.white, for: .normal)
		priceButton.layer.cornerRadius = 32 / 2
	}
	
	private func setupLayout() {
		
		appIconImageView.constrainWidth(constant: 140)
		appIconImageView.constrainHeight(constant: 140)
		
		priceButton.constrainHeight(constant: 32)
		priceButton.constrainWidth(constant: 80)
		
		// NAME INFO PRICE VERTICAL STACK
		let nameInfoPriceStackView = UIStackView(arrangedSubviews: [
			nameLabel,
			UIStackView(arrangedSubviews: [priceButton, UIView()]),
			UIView()
		])
		nameInfoPriceStackView.axis = .vertical
		nameInfoPriceStackView.spacing = 12
		
		// IMAGE + (NAME, INFO, PRICE) HORIZONTAL STACK
		let topSection = UIStackView(arrangedSubviews: [
			appIconImageView,
			nameInfoPriceStackView
		])
		topSection.spacing = 20
		
		// ROOT STACK
		let rootStackView = UIStackView(arrangedSubviews: [
			topSection,
			whatsNewLabel,
			releaseNotesLabel
		])
		rootStackView.spacing = 16
		rootStackView.axis = .vertical
		
		addSubview(rootStackView)
		rootStackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
	}
}
