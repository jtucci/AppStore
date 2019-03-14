//
//  ReviewCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/14/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

final class ReviewCell: UICollectionViewCell {
	
	//MARK:- Properties
	let titleLabel = UILabel(text: "Review Title", font: UIFont.boldSystemFont(ofSize: 18))
	let authorLabel = UILabel(text: "Author", font: UIFont.systemFont(ofSize: 16))
	let starsLabel = UILabel(text: "Stars", font: UIFont.systemFont(ofSize: 14))
	let starsStackView: UIStackView = {
		var arrangedSubviews = [UIView]()
		(0..<5).forEach({ (_) in
			let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
			imageView.constrainWidth(constant: 24)
			imageView.constrainHeight(constant: 24)
			arrangedSubviews.append(imageView)
		})
		arrangedSubviews.append(UIView())
		let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
		return stackView
	}()
	
	let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\n", font: UIFont.systemFont(ofSize: 18), numberOfLines: 5)
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupProperties()
		setupLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Setup
	private func setupProperties() {
		backgroundColor = #colorLiteral(red: 0.9479298858, green: 0.9479298858, blue: 0.9479298858, alpha: 1)
		layer.cornerRadius = 16
		clipsToBounds = true
	}
	
	private func setupLayout() {
		titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
		authorLabel.textAlignment = .right
		
		let titleAuthorStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
		titleAuthorStackView.spacing = 8
		
		let rootStackView = UIStackView(arrangedSubviews: [
			titleAuthorStackView,
			starsStackView,
			bodyLabel
			])
		rootStackView.axis = .vertical
		rootStackView.spacing = 12
		
		
		addSubview(rootStackView)
		rootStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
	}
}
