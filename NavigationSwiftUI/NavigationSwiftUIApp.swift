//
//  NavigationSwiftUIApp.swift
//  NavigationSwiftUI
//
//  Created by Meezu Lawot on 24/09/2023.
//

import SwiftUI

@main
struct NavigationSwiftUIApp: App {
    
    @StateObject var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(sessionManager)
        }
    }
}
