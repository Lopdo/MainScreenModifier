//
//  NavigationBarConfigurable.swift
//  MainScreenModifier
//
//  Created by Lope on 03/07/2023.
//

import SwiftUI

protocol NavigationBarConfigurable {
	var canGoBack: Bool { get }
	var navigationTitle: String { get }
	var navBarTheme: NavBarTheme { get }
}

struct NavigationBarConfigurationModifier: ViewModifier {
	//let title: String
	//let hostController: UIViewController?

	var canGoBack: Bool = true
	var navigationTitle: String = "My title"
	var navBarTheme: NavBarTheme = .red

	func body(content: Content) -> some View {
		content
			//.navigationTitle(navigationTitle)
			//We are using custom back button in the app (controller by `canGoBack` property) so we are always hiding system back button
			.navigationBarBackButtonHidden(true)
	}
}

extension View {
	func myMainScreenModifier(title: String, canGoBack: Bool = true, theme: NavBarTheme = .red) -> some View {
		modifier(NavigationBarConfigurationModifier(canGoBack: canGoBack, navigationTitle: title, navBarTheme: theme))
	}
}
