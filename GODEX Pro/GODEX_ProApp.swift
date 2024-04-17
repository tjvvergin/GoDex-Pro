//
//  GODEX_ProApp.swift
//  GODEX Pro
//
//  Created by Tyler Vergin on 5/10/23.
//

import SwiftUI

@main
struct GODEX_ProApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(myDex)
        }
    }
}
