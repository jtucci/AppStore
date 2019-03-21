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
	let floatingContainerView = UIView()
	
	let closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
		return button
	}()
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		setupCloseButton()
		setupFloatingControls()
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
	
	//MARK:- Scroll View
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: -90) : .identity
		
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
			
			self.floatingContainerView.transform = transform
		}, completion: nil)
		
	}
	
	//MARK:- Setup
	private func setupCloseButton() {
		view.addSubview(closeButton)
		closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
		closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
	}
	
	private func setupTableView() {
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
	}
	

	private func setupFloatingControls() {
		
		// Float View
		//let floatingContainerView = UIView()
		floatingContainerView.clipsToBounds = true
		floatingContainerView.layer.cornerRadius = 16
		view.addSubview(floatingContainerView)
		floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90, right: 16), size: .init(width: 0, height: 90))
		
		// Blur Effect
		let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
		floatingContainerView.addSubview(blurVisualEffectView)
		blurVisualEffectView.fillSuperview()
		
		
		// Add subviews to Float view
		let imageView = UIImageView(cornerRadius: 16)
		imageView.image = todayItem?.image
		imageView.constrainHeight(constant: 68)
		imageView.constrainWidth(constant: 68)
		
		let getButton = UIButton(title: "GET")
		getButton.setTitleColor(.white, for: .normal)
		getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		getButton.backgroundColor = .darkGray
		getButton.layer.cornerRadius = 16
		getButton.constrainWidth(constant: 80)
		getButton.constrainHeight(constant: 32)
		
		// Subview Layout
		let labelStackView = UIStackView(arrangedSubviews: [
			UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18)),
			UILabel(text: "Utilizing your Time", font: .systemFont(ofSize: 16))
		])
		labelStackView.axis = .vertical
		labelStackView.spacing = 4
		
		let rootStackView = UIStackView(arrangedSubviews: [
			imageView,
			labelStackView,
			getButton
			
		])
		rootStackView.spacing = 16
		
		floatingContainerView.addSubview(rootStackView)
		rootStackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
		rootStackView.alignment = .center
	}
	
	
	//MARK:- Handlers
	@objc private func handleDismiss(button: UIButton) {
		button.isHidden = true
		dismissHandler?()
	}
}
