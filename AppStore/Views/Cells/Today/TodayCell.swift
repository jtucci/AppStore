//
//  TodayCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/16/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
	
	//MARK:- Properties
	override var todayItem: TodayItem! {
		didSet{
			categoryLabel.text = todayItem.category
			titleLabel.text = todayItem.title
			imageView.image = todayItem.image
			descriptionLabel.text = todayItem.description
			backgroundColor = todayItem.backgroundColor
			backgroundView?.backgroundColor = todayItem.backgroundColor
		}
	}
	
	var topConsraint: NSLayoutConstraint!
	
	let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
	let categoryLabel = UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 20))
	let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
	let descriptionLabel = UILabel(text: "All the tools and apps your need to intelligently organize your life the right way", font: .systemFont(ofSize: 16), numberOfLines: 3)
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let imageContainerView = UIView()
		imageContainerView.addSubview(imageView)
		imageView.centerInSuperview(size: .init(width: 240, height: 240))
		
		backgroundColor = .white
		layer.cornerRadius = 16
		
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		
		
		let rootStackView = UIStackView(arrangedSubviews: [
			categoryLabel, titleLabel, imageContainerView, descriptionLabel
		])
		rootStackView.axis = .vertical
		rootStackView.spacing = 8
		
		addSubview(rootStackView)
		rootStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
		
		self.topConsraint = rootStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
		self.topConsraint.isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
