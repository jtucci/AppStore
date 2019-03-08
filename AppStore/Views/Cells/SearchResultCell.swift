//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/8/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
	
	//MARK:- Properties
	
	// Image view used for app icon image
	let imageView: UIImageView = {
		let iv = UIImageView()
		iv.backgroundColor = .red
		
		iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
		iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
		iv.layer.cornerRadius = 12
		return iv
	}()
	
	// Label used for app name
	let nameLabel: UILabel = {
		let label = UILabel()
		label.text = "APP NAME"
		label.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
		return label
	}()
	
	let categoryLabel: UILabel = {
		let label = UILabel()
		label.text = "Photos & Video"
		label.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
		return label
	}()
	
	let ratingsLabel: UILabel = {
		let label = UILabel()
		label.text = "9.26M"
		label.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
		return label
	}()
	
	// Button used for the 'get' app feature
	let getButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("GET", for: .normal)
		button.setTitleColor(.blue, for: .normal)
		button.titleLabel?.font = .boldSystemFont(ofSize: 14)
		button.backgroundColor = .darkGray
		button.widthAnchor.constraint(equalToConstant: 80).isActive = true
		button.layer.cornerRadius = 16
		return button
	}()
	
	
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .yellow
		
		let labelsStackView = UIStackView(arrangedSubviews: [
			nameLabel, categoryLabel, ratingsLabel
		])
		
		labelsStackView.axis = .vertical
		
		let stackView = UIStackView(arrangedSubviews: [
				imageView, labelsStackView, getButton
		])
		
		stackView.alignment = .center
		
		stackView.spacing = 12
		
		addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
		stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
