//
//  ViewController.swift
//  MainScreenModifier
//
//  Created by Lope on 03/07/2023.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		setNavbarThemeWith(barTintColor: .blue)
	}

	@IBAction private func openScreenP() {
		let vc = MyHostingController(rootView: SwiftUIScreenP(), navController: navigationController)
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction private func openScreenM() {
		let vc = MyHostingController(rootView: SwiftUIScreenM(), navController: navigationController)
		navigationController?.pushViewController(vc, animated: true)
	}
	

	private func setNavbarThemeWith(barTintColor: UIColor, titleColor: UIColor = .white) {

		navigationController?.navigationBar.tintColor = titleColor

		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = barTintColor
		appearance.titleTextAttributes = [.foregroundColor: titleColor]

		navigationController?.navigationBar.tintColor = titleColor

		navigationItem.standardAppearance = appearance
		navigationItem.scrollEdgeAppearance = appearance

		navigationController?.navigationBar.barStyle = .black
		setNeedsStatusBarAppearanceUpdate()
		//updateStatusBarStyle()
	}
}

