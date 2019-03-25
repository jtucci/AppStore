//
//  MusicLoadingFooter.swift
//  AppStore
//
//  Created by Jony Tucci on 3/25/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
	
	//MARK:- Properties
	
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let aiv = UIActivityIndicatorView(style: .whiteLarge)
		aiv.color = .darkGray
		aiv.startAnimating()
		
		let label = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
		label.textAlignment = .center
		
		let stackView = UIStackView(arrangedSubviews: [
			aiv, label
		])
		stackView.spacing = 8
		addSubview(stackView)
		stackView.centerInSuperview(size: .init(width: 200, height: 0))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
