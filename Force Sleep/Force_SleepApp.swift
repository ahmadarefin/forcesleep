//
//  Force_SleepApp.swift
//  Force Sleep
//
//  Created by Ahmad Arefin on 19/04/2026.
//

import SwiftUI

@main
struct Force_SleepApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    NSApplication.shared.windows.first?.setContentSize(NSSize(width: 400, height: 500))
                    NSApplication.shared.windows.first?.center()
                }
        }
        .defaultSize(width: 400, height: 500)
        .windowResizability(.contentSize)
    }
}
