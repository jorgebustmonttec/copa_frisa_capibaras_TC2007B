//
//  Leaderboard.swift
//  minion
//
//  Created by Jorge Bustamante on 10/06/24.
//
// LeaderboardView.swift
import SwiftUI

struct LeaderboardView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Category", selection: $selectedTab) {
                    Text("Puntos").tag(0)
                    Text("Goleo").tag(1)
                    Text("Fair Play").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TabView(selection: $selectedTab) {
                    PuntosView()
                        .tabItem { Text("Puntos") }
                        .tag(0)

                    Text("Goleo Content")
                        .tabItem { Text("Goleo") }
                        .tag(1)

                    Text("Fair Play Content")
                        .tabItem { Text("Fair Play") }
                        .tag(2)
                }
            }
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
