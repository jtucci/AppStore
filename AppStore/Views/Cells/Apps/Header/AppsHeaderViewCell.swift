//
//  AppsHeaderCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
	
	//MARK:- Properties
	let companyLabel = UILabel(text: "FaceBook", font: .boldSystemFont(ofSize: 12))
	let titleLabel = UILabel(text: "Keeping up with freinds is faster than ever", font: .systemFont(ofSize: 24))
	let imageView = UIImageView(cornerRadius: 8)
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		imageView.backgroundColor = .red
		titleLabel.numberOfLines = 2
		setupCellLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Setup
	private func setupCellLayout() {
		let rootStackView = UIStackView(arrangedSubviews: [companyLabel, titleLabel, imageView])
		rootStackView.axis = .vertical
		rootStackView.spacing = 12
		addSubview(rootStackView)
		rootStackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
	}
}
