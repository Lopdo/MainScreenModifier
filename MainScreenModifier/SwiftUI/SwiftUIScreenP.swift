//
//  SwiftUIScreen.swift
//  MainScreenModifier
//
//  Created by Lope on 03/07/2023.
//

import SwiftUI

// This screen represents my current implementation, it is using protocol conformance
// which I can check for in the hosting view controller, because this will
// always be rootView. This however has a disatvatage of having to declare all
// protocol's properties and then pass it to the modifier (even those that could have default values).
// Both solutions use same modifier, difference is in how we feed data to it.

struct SwiftUIScreenP: View, NavigationBarConfigurable {
	
	//NavigationBarConfigurable
	var canGoBack: Bool = true
	var navigationTitle: String = "My Title"
	var navBarTheme: NavBarTheme = .red

    var body: some View {
        Text("SwiftUI Screen")
			.myMainScreenModifier(title: navigationTitle, canGoBack: canGoBack, theme: navBarTheme)

    }
}

struct SwiftUIScreen_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIScreenP()
    }
}
