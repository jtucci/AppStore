//
//  TodayCellFullScreenController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/17/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TodayCellFullScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	//MARK:- Properties
	var dismissHandler: (() -> ())?
	var todayItem: TodayItem?
	let tableView = UITableView(frame: .zero, style: .plain)
	
	let closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
		return button
	}()
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(tableView)
		view.clipsToBounds = true
		tableView.fillSuperview()
		tableView.dataSource = self
		tableView.delegate = self
		tableView.tableFooterView = UIView()
		tableView.separatorStyle = .none
		tableView.allowsSelection = false
		let height = UIApplication.shared.statusBarFrame.height
		tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
		tableView.contentInsetAdjustmentBehavior = .never
		
		setupCloseButton()
	}
	
	//MARK:- TableView Data Source
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.item == 0 {
			let headerCell = TodayFullScreenHeaderCell()
			headerCell.todayCell.todayItem = todayItem
			headerCell.todayCell.layer.cornerRadius = 0
			headerCell.clipsToBounds = true
			return headerCell
		}
		
		let cell = TodayFullScreenDescriptionCell()
		return cell 
	}
	
	//MARK:- TableView layout
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return TodayController.cellSize
		}
		return UITableView.automaticDimension
		
	}
	
	//MARK:- Handlers
	@objc private func handleDismiss(button: UIButton) {
		button.isHidden = true
		dismissHandler?()
	}
	
	//MARK:- Setup
	private func setupCloseButton() {
		view.addSubview(closeButton)
		closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
		closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
	}
}
