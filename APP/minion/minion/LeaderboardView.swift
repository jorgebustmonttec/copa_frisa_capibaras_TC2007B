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

                if selectedTab == 0 {
                    Text("Puntos Content")
                } else if selectedTab == 1 {
                    Text("Goleo Content")
                } else if selectedTab == 2 {
                    Text("Fair Play Content")
                }

                Spacer()
            }
            .navigationTitle("Leaderboard")
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
