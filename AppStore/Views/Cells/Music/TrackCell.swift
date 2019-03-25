//
//  TrackCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/25/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {
	
	//MARK:- Properties
	let imageView = UIImageView(cornerRadius: 16)
	let nameLabel = UILabel(text: "Track Name", font: UIFont.boldSystemFont(ofSize: 18))
	let subtitleLabel = UILabel(text: "Subtitle Label", font: .systemFont(ofSize: 16), numberOfLines: 2)
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		imageView.image = #imageLiteral(resourceName: "garden")
		imageView.constrainWidth(constant: 80)
		
		let labelStackView = UIStackView(arrangedSubviews: [
			nameLabel,
			subtitleLabel
		])
		labelStackView.axis = .vertical
		labelStackView.spacing = 16
		
		
		let rootStackView = UIStackView(arrangedSubviews: [
			imageView, labelStackView
		])
		rootStackView.spacing = 16
		rootStackView.alignment = .center
		
		addSubview(rootStackView)
		rootStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	
}
