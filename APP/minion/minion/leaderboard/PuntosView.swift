//
//  PuntosView.swift
//  minion
//
//  Created by Jorge Bustamante on 10/06/24.
//
import SwiftUI

struct PuntosView: View {
    @State private var equipos: [EquipoPuntosChart] = []
    @State private var equiposData: [Int: APIEquipo] = [:]
    @State private var errorMessage: String = ""
    @State private var teamShields: [Int: UIImage] = [:]

    var body: some View {
        VStack {
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(equipos.indices, id: \.self) { index in
                    if let equipo = equiposData[equipos[index].id_equipo] {
                        NavigationLink(destination: EquipoDetailView(equipoId: equipo.id_equipo)) {
                            HStack {
                                if let shield = teamShields[equipo.id_equipo] {
                                    Image(uiImage: shield)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                } else {
                                    ProgressView()
                                        .frame(width: 40, height: 40)
                                }
                                Text("\(index + 1)")
                                    .bold()
                                VStack(alignment: .leading) {
                                    Text(equipo.nombre_equipo)
                                        .font(.headline)
                                    Text(equipo.escuela)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("\(equipos[index].total_points)")
                                    .bold()
                            }
                            .padding()
                            .background(getBackgroundColor(for: index))
                            .cornerRadius(10)
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
        }
        .onAppear {
            fetchEquiposOrderedByPoints()
        }
        .navigationTitle("Leaderboard")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func getBackgroundColor(for index: Int) -> Color {
        switch index {
        case 0:
            return Color.yellow.opacity(0.3)
        case 1:
            return Color.gray.opacity(0.3)
        case 2:
            return Color.orange.opacity(0.3)
        default:
            return Color.clear
        }
    }

    private func fetchEquiposOrderedByPoints() {
        let url = "https://localhost:3443/partidos/teams/ordered-by-points"
        APIService.shared.fetchEquiposOrderedByPoints(url: url) { result in
            switch result {
            case .success(let equipos):
                self.equipos = equipos
                fetchEquiposData()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchEquiposData() {
        for equipo in equipos {
            let url = "https://localhost:3443/equipos/single/\(equipo.id_equipo)"
            APIService.shared.fetchEquipo(url: url) { result in
                switch result {
                case .success(let equipoData):
                    self.equiposData[equipo.id_equipo] = equipoData
                    fetchTeamShield(teamId: equipoData.id_equipo)
                case .failure(let error):
                    print("Failed to fetch team \(equipo.id_equipo): \(error.localizedDescription)")
                }
            }
        }
    }

    private func fetchTeamShield(teamId: Int) {
        let url = "https://localhost:3443/equipos/single/\(teamId)/escudo"
        APIService.shared.fetchEquipoShield(url: url) { result in
            switch result {
            case .success(let shieldData):
                if let image = UIImage(data: shieldData) {
                    self.teamShields[teamId] = image
                }
            case .failure(let error):
                print("Failed to fetch team \(teamId) shield: \(error.localizedDescription)")
            }
        }
    }
}

struct PuntosView_Previews: PreviewProvider {
    static var previews: some View {
        PuntosView()
    }
}
