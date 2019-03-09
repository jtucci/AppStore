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
	var appResult: Result! {
		didSet{
			nameLabel.text = appResult.trackName
			categoryLabel.text = appResult.primaryGenreName
			ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
			
			let url = URL(string: appResult.artworkUrl100)
			appIconImageView.sd_setImage(with: url)
			
			screenShotImageView1.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
			if appResult.screenshotUrls.count > 1 {
				screenShotImageView2.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
			}
			if appResult.screenshotUrls.count > 2 {
				screenShotImageView3.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
			}
		}
	}
	
	
	let appIconImageView: UIImageView = {
		let iv = UIImageView()
		iv.backgroundColor = .red
		
		iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
		iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
		iv.layer.cornerRadius = 12
		iv.clipsToBounds = true
		return iv
	}()
	
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
	
	let getButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("GET", for: .normal)
		button.setTitleColor(.blue, for: .normal)
		button.titleLabel?.font = .boldSystemFont(ofSize: 14)
		button.backgroundColor = .darkGray
		button.widthAnchor.constraint(equalToConstant: 80).isActive = true
		button.heightAnchor.constraint(equalToConstant: 32).isActive = true
		button.layer.cornerRadius = 16
		return button
	}()
	
	lazy var screenShotImageView1 = self.createScreenShotImageView()
	lazy var screenShotImageView2 = self.createScreenShotImageView()
	lazy var screenShotImageView3 = self.createScreenShotImageView()
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupCellLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Setup
	private func setupCellLayout() {
		// Labels STACK VIEW (used inside top stack view)
		let labelsStackView = UIStackView(arrangedSubviews: [
			nameLabel, categoryLabel, ratingsLabel
			])
		labelsStackView.axis = .vertical
		
		
		// TOP STACK VIEW
		let infoTopStackView  = UIStackView(arrangedSubviews: [
			appIconImageView, labelsStackView, getButton
			])
		infoTopStackView.alignment = .center
		infoTopStackView.spacing = 12
		
		
		// BOTTOM STACK VIEW (ScreenShot image previews)
		let screenShotBottomStackView = UIStackView(arrangedSubviews: [
			screenShotImageView1,
			screenShotImageView2,
			screenShotImageView3
			])
		screenShotBottomStackView.spacing = 12
		screenShotBottomStackView.distribution = .fillEqually
		
		
		// ROOT STACK VIEW (contains all)
		let rootStackView = UIStackView(arrangedSubviews: [
			infoTopStackView, screenShotBottomStackView
			])
		rootStackView.axis = .vertical
		rootStackView.spacing = 16
		
		addSubview(rootStackView)
		rootStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
	}
	
	//MARK:- Helper
	private func createScreenShotImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.backgroundColor = .purple
		imageView.layer.cornerRadius = 8
		imageView.clipsToBounds = true
		imageView.layer.borderWidth = 0.5
		imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
		imageView.contentMode = .scaleAspectFill
		return imageView
	}
}
