//
//  BusquedaView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//
// Definición del enum SearchResult
import SwiftUI

struct BusquedaView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select a category", selection: $selectedTab) {
                    Text("Jugadores").tag(0)
                    Text("Equipos").tag(1)
                    Text("Partidos").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TabView(selection: $selectedTab) {
                    JugadoresView()
                        .tabItem { Text("Jugadores") }
                        .tag(0)

                    EquiposView()
                        .tabItem { Text("Equipos") }
                        .tag(1)

                    PartidosView()
                        .tabItem { Text("Partidos") }
                        .tag(2)
                }
            }
            .navigationTitle("Búsqueda")
            .searchable(text: $searchText)
        }
    }
}

struct JugadoresView: View {
    var body: some View {
        VStack {
            Text("Jugadores")
            Spacer()
        }
    }
}

struct EquiposView: View {
    var body: some View {
        VStack {
            Text("Equipos")
            Spacer()
        }
    }
}

struct PartidosView: View {
    var body: some View {
        VStack {
            Text("Partidos")
            Spacer()
        }
    }
}

struct BusquedaView_Previews: PreviewProvider {
    static var previews: some View {
        BusquedaView()
    }
}
