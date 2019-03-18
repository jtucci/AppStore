//
//  TodayItem.swift
//  AppStore
//
//  Created by Jony Tucci on 3/17/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

struct TodayItem {
	
	let category: String
	let title: String
	let image: UIImage
	let description: String
	let backgroundColor: UIColor 
	
	let cellType: CellType
	
	let apps: [FeedResult]
	
	enum CellType: String {
		case single, multiple
	}
}
