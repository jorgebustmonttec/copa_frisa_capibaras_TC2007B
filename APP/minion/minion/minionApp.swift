//
//  minionApp.swift
//  minion
//
//  Created by Jorge Bustamante on 05/06/24.
//
import SwiftUI

@main
struct minionApp: App {
    @StateObject private var userViewModel = UserViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
        }
    }
}
