//
//  SwiftUIScreenM.swift
//  MainScreenModifier
//
//  Created by Lope on 06/07/2023.
//

import SwiftUI

// This screen represents what I want to achieve, there is no protocol conformance,
// so the code is much simpler and I only have to pass those properties that are
// different from "default" behaviour.
// Both solutions use same modifier, difference is in how we feed data to it.

struct SwiftUIScreenM: View {

	var body: some View {
		Text("SwiftUI Screen")
			.myMainScreenModifier(title: "My Title")

	}
}

struct SwiftUIScreenM_Previews: PreviewProvider {
	static var previews: some View {
		SwiftUIScreenM()
	}
}
