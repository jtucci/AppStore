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
	
	//MARK:- Initialization
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(todayCell)
		todayCell.fillSuperview()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
