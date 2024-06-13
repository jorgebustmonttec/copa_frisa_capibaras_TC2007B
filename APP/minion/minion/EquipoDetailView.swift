//
//  EquipoDetailView.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
//
//  EquipoDetailView.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import SwiftUI

struct EquipoDetailView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var equipo: APIEquipo?
    @State private var jugadores: [APIJugadorEquipo] = []
    @State private var teamShield: UIImage?
    @State private var errorMessage: String = ""
    @State private var totalGoals: Int = 0
    @State private var totalPoints: Int = 0
    @State private var totalWins: Int = 0

    var equipoId: Int

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                if let equipo = equipo {
                    HStack {
                        if let shield = teamShield {
                            Image(uiImage: shield)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        } else {
                            ProgressView()
                                .frame(width: 60, height: 60)
                        }
                        VStack(alignment: .leading) {
                            Text(equipo.nombre_equipo)
                                .font(.title)
                                .bold()
                            Text(equipo.escuela)
                                .font(.subheadline)
                        }
                    }
                    
                    HStack(spacing: 20) {
                        StatisticView(label: "Goles", value: String(totalGoals))
                        StatisticView(label: "Puntos", value: String(totalPoints))
                        StatisticView(label: "Juegos Ganados", value: String(totalWins))
                    }

                    Divider()

                    Text("Jugadores")
                        .font(.headline)

                    List(jugadores, id: \.id_jugador) { jugador in
                        NavigationLink(destination: JugadorPerfilView(userId: jugador.id_usuario)) {
                            Text(jugador.nombre)
                        }
                    }
                    
                    Spacer()
                } else if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ProgressView("Cargando datos...")
                        .padding()
                }
            }
            .padding()
            .navigationBarTitle("Detalles del Equipo", displayMode: .inline)
            .onAppear {
                fetchEquipoData()
            }
        }
    }

    private func fetchEquipoData() {
        let equipoUrl = "https://localhost:3443/equipos/single/\(equipoId)"
        APIService.shared.fetchEquipo(url: equipoUrl) { equipoResult in
            switch equipoResult {
            case .success(let equipo):
                self.equipo = equipo
                fetchTeamShield(teamId: equipo.id_equipo)
                fetchJugadores(equipoId: equipoId)
                fetchTeamStats(equipoId: equipo.id_equipo)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchJugadores(equipoId: Int) {
        let url = "https://localhost:3443/jugadores/equipo/\(equipoId)"
        APIService.shared.fetchJugadores(url: url) { result in
            switch result {
            case .success(let jugadores):
                self.jugadores = jugadores
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchTeamShield(teamId: Int) {
        APIService.shared.fetchEquipoShield(by: teamId) { result in
            switch result {
            case .success(let shieldData):
                if let image = UIImage(data: shieldData) {
                    self.teamShield = image
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchTeamStats(equipoId: Int) {
        let goalsUrl = "https://localhost:3443/puntos/goles/equipo/\(equipoId)/total"
        APIService.shared.fetchTotalGoalsByTeam(url: goalsUrl) { result in
            switch result {
            case .success(let totalGoals):
                self.totalGoals = totalGoals
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }

        let pointsUrl = "https://localhost:3443/partidos/points/\(equipoId)"
        APIService.shared.fetchTotalPointsByTeam(url: pointsUrl) { result in
            switch result {
            case .success(let totalPoints):
                self.totalPoints = totalPoints
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }

        let winsUrl = "https://localhost:3443/partidos/wins/\(equipoId)"
        APIService.shared.fetchTotalWinsByTeam(url: winsUrl) { result in
            switch result {
            case .success(let totalWins):
                self.totalWins = totalWins
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}



struct EquipoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EquipoDetailView(equipoId: 1).environmentObject(UserViewModel())
    }
}
