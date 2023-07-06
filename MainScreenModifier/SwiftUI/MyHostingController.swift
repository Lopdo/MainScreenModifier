//
//  MyHostingController.swift
//  MainScreenModifier
//
//  Created by Lope on 03/07/2023.
//

import UIKit
import SwiftUI

class MyHostingController<Content>: UIHostingController<Content> where Content: View {

	var navBarTheme: NavBarTheme?
	var canGoBack: Bool = true

	public init(rootView: Content, navController: UINavigationController?) {

		super.init(rootView: rootView)

		if rootView is SwiftUIScreenP {
			getPropertiesFromProtocol(rootView: rootView)
		} else {
			getPropertiesFromModifier(rootView: rootView)
		}



		// There is a bug in iOS <=14.4 which causes `viewDidLoad` not getting called
		// so we need to do the setup manually here
		if #available(iOS 14.5, *) {
			//No special handling
		} else {
			updateNavbarTheme()
			setupBackButton()
		}
	}

	// This method just checks for protocol conformance by optional casting and then extract data from protocol
	// It is easy and works great, but requires a lot of boilerplate in the screen's code
	private func getPropertiesFromProtocol(rootView: Content) {
		if let navBarConfigurableView = rootView as? NavigationBarConfigurable {
			canGoBack = navBarConfigurableView.canGoBack
			navigationItem.title = navBarConfigurableView.navigationTitle

			navBarTheme = navBarConfigurableView.navBarTheme
		}
	}

	// !!!! vvv The problem is here vvv !!!

	// This method is trying to extract screen's modifier. The modifier would have to be last one added for it to work
	// but that's fine (not ideal, but manageable). However, I can't figure out how to get the modifier and its data.
	// I tried various types of casting, but nothing that would keep MyHostingController generic worked
	private func getPropertiesFromModifier(rootView: Content) {
		/*if let modifier = (rootView as? ModifiedContent<any View, NavigationBarConfigurationModifier>)?.content.modifier {
			canGoBack = modifier.canGoBack
			navigationItem.title = modifier.navigationTitle

			navBarTheme = modifier.navBarTheme
		}*/
	}






	// You can ignore everything under this comment. It is used to actually setup up the navigation bar and is not relevant to the problem itself.
	// I kept it there just so we can see that the change in protocol (or modifier) property has an effect

	func getNavbarTheme() -> NavBarTheme? {
		return navBarTheme
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		updateNavbarTheme()
		setupBackButton()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		updateNavbarTheme()
	}

	private func updateNavbarTheme() {
		if navBarTheme == .red {
			setNavbarThemeWith(barTintColor: .red)
		} else {
			setNavbarThemeWith(barTintColor: .blue)
		}
	}

	func setupBackButton() {

		if self.navigationController?.viewControllers.count == 1 {
			//there's only 1 view controller, we don't need a back button
			return
		}


		navigationItem.hidesBackButton = !canGoBack

		if canGoBack {
			let backButton = UIBarButtonItem(image: UIImage(named: "btn_back"), style: .plain, target: self, action: #selector(moveBack))
			backButton.accessibilityLabel = "Back"
			navigationItem.setLeftBarButton(backButton, animated: false)
		}
	}


	@objc func moveBack() {
		navigationController?.popViewController(animated: true)
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
	}
	
}

extension MyHostingController: ObservableObject { }

extension MyHostingController {

	static func push(view: Content, onto navigationController: UINavigationController?) {
		let vc = MyHostingController(rootView: view, navController: navigationController)
		navigationController?.pushViewController(vc, animated: true)
	}

}

class MyHostWrapper: ObservableObject {
	weak var viewController: UIViewController?
	weak var navigationController: UINavigationController?
}
