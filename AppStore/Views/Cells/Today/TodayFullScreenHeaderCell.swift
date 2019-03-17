//
//  TodayFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/17/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TodayFullScreenHeaderCell: UITableViewCell {
	
	//MARK:- Properties
	let todayCell = TodayCell()
	let closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
		return button
	}()
	
	//MARK:- Initialization
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		addSubview(todayCell)
		todayCell.fillSuperview()
		
		addSubview(closeButton)
		closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
