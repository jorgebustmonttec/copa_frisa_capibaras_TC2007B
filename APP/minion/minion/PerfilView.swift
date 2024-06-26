//
//  PerfilView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//
import SwiftUI

struct PerfilView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var jugador: APIJugador?
    @State private var equipo: APIEquipo?
    @State private var lastGameInfo: APILastGameInfo?
    @State private var greenCards: Int = 0
    @State private var totalGoals: Int = 0
    @State private var errorMessage: String = ""

    var body: some View {
        if userViewModel.isLoggedIn {
            if userViewModel.userType == 2 {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        if let jugador = jugador, let equipo = equipo {
                            Spacer(minLength: 20)
                            
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90, height: 90)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                
                                VStack(alignment: .leading) {
                                    Text(jugador.display_name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    NavigationLink(destination: EquipoDetailView(equipoId: jugador.id_equipo)) {
                                        Text(equipo.nombre_equipo)
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }

                            Divider()
                            
                            Group {
                                StatisticView(label: "Goles", value: String(totalGoals))
                                StatisticView(label: "Posición", value: jugador.posicion)
                                StatisticView(label: "Tarjetas Verdes", value: String(greenCards))
                                if let lastGameInfo = lastGameInfo {
                                    StatisticView(label: "Último Juego", value: formatDate(lastGameInfo.date))
                                    StatisticView(label: "Resultado", value: lastGameInfo.result)
                                }
                            }
                            .padding(.vertical, 2)
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
                }
                .navigationBarTitle("Perfil del Jugador", displayMode: .inline)
                .onAppear {
                    fetchJugadorData()
                }
            } else {
                VStack {
                    Text("No eres jugador pero puedes buscar otros jugadores.")
                        .padding()
                    NavigationLink(destination: BusquedaView()) {
                        Text("Buscar Jugadores")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
        } else {
            VStack {
                Text("No has iniciado sesión.")
                    .padding()
                NavigationLink(destination: BusquedaView()) {
                    Text("Buscar Jugadores")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    NavigationLink(destination: ContentView().navigationBarHidden(true)) {
                        Text("Ir a Iniciar Sesión")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }
    
    private func fetchJugadorData() {
        guard let userId = userViewModel.userId else {
            self.errorMessage = "ID de usuario no disponible"
            return
        }

        let url = "https://localhost:3443/jugadores/singlebyuser/\(userId)"
        APIService.shared.fetchJugador(url: url) { result in
            switch result {
            case .success(let jugador):
                self.jugador = jugador
                fetchEquipoData(teamId: jugador.id_equipo)
                fetchLastGameInfo(userId: userId)
                fetchGreenCardsData(playerId: jugador.id_jugador)
                fetchGoalsData(userId: userId)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchEquipoData(teamId: Int) {
        let url = "https://localhost:3443/equipos/single/\(teamId)"
        APIService.shared.fetchEquipo(url: url) { result in
            switch result {
            case .success(let equipo):
                self.equipo = equipo
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchLastGameInfo(userId: Int) {
        let url = "https://localhost:3443/partidos/lastgamebyuser/\(userId)"
        APIService.shared.fetchLastGameInfo(url: url) { result in
            switch result {
            case .success(let lastGameInfo):
                self.lastGameInfo = lastGameInfo
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchGreenCardsData(playerId: Int) {
        let url = "https://localhost:3443/puntos/green/player/\(playerId)"
        APIService.shared.fetchGreenCards(url: url) { result in
            switch result {
            case .success(let greenCards):
                self.greenCards = greenCards.total_green_cards
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchGoalsData(userId: Int) {
        let url = "https://localhost:3443/puntos/goles/usuario/\(userId)/total"
        APIService.shared.fetchGoals(url: url) { result in
            switch result {
            case .success(let goals):
                self.totalGoals = goals.total_goals
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func formatDate(_ dateStr: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: dateStr) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .none // No time, only date
            return displayFormatter.string(from: date)
        }
        return dateStr
    }
}

struct StatisticView: View {
    var label: String
    var value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView().environmentObject(UserViewModel())
    }
}
