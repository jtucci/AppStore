//
//  TodayCellFullScreenController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/17/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TodayCellFullScreenController: UITableViewController {
	
	//MARK:- Properties
	var dismissHandler: (() -> ())?
	var todayItem: TodayItem?
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.tableFooterView = UIView()
		tableView.separatorStyle = .none
		tableView.allowsSelection = false
		let height = UIApplication.shared.statusBarFrame.height
		tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
		tableView.contentInsetAdjustmentBehavior = .never
	}
	
	//MARK:- TableView Data Source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.item == 0 {
			let headerCell = TodayFullScreenHeaderCell()
			headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
			headerCell.todayCell.todayItem = todayItem
			headerCell.todayCell.layer.cornerRadius = 0
			return headerCell
		}
		
		let cell = TodayFullScreenDescriptionCell()
		return cell 
	}
	
	//MARK:- TableView layout
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return TodayController.cellSize
		}
		return super.tableView(tableView, heightForRowAt: indexPath)
	}
	
	//MARK:- Handlers
	@objc private func handleDismiss(button: UIButton) {
		button.isHidden = true
		dismissHandler?()
	}
	

	
}
