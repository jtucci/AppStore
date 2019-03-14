//
//  ReviewCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/14/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
	
	//MARK:- Properties
	let titleLabel = UILabel(text: "Review Title", font: UIFont.boldSystemFont(ofSize: 18))
	let authorLabel = UILabel(text: "Author", font: UIFont.systemFont(ofSize: 16))
	let starsLabel = UILabel(text: "Stars", font: UIFont.systemFont(ofSize: 14))
	let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\n", font: UIFont.systemFont(ofSize: 16), numberOfLines: 0)
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = #colorLiteral(red: 0.9479298858, green: 0.9479298858, blue: 0.9479298858, alpha: 1)
		layer.cornerRadius = 16
		clipsToBounds = true
		
		
		titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
		authorLabel.textAlignment = .right
		
		let titleAuthorStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
		titleAuthorStackView.spacing = 8
		
		let rootStackView = UIStackView(arrangedSubviews: [
			titleAuthorStackView,
			starsLabel,
			bodyLabel
		])
		rootStackView.axis = .vertical
		rootStackView.spacing = 12
		
		
		addSubview(rootStackView)
		rootStackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
