//
//  PreviewCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/13/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

final class PreviewRowCell: UICollectionViewCell {
	
	//MARK:- Properties
	let previewLabel = UILabel(text: "Preview", font: UIFont.boldSystemFont(ofSize: 20))
	let horizontalController = PreviewScreenShotsHorizontalController()
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Setup
	private func setupLayout() {
		addSubview(previewLabel)
		addSubview(horizontalController.view)
		
		previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
		horizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
	}
	
}

