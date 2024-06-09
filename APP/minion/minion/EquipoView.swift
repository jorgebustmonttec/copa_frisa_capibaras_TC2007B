//
//  EquipoView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//
import SwiftUI

struct EquipoView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var equipo: APIEquipo?
    @State private var jugadores: [APIJugadorEquipo] = []
    @State private var errorMessage: String = ""

    var body: some View {
        if userViewModel.isLoggedIn {
            NavigationView {
                VStack(alignment: .leading, spacing: 20) {
                    if let equipo = equipo {
                        HStack {
                            Image(systemName: "shield.lefthalf.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading) {
                                Text(equipo.nombre_equipo)
                                    .font(.title)
                                    .bold()
                                Text(equipo.escuela)
                                    .font(.subheadline)
                            }
                        }

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
        } else {
            VStack {
                Text("No has iniciado sesion.")
                    .padding()
                NavigationLink(destination: BusquedaView()) {
                    Text("Buscar Equipos")
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

    private func fetchEquipoData() {
        guard let userId = userViewModel.userId else {
            self.errorMessage = "ID de usuario no disponible"
            return
        }

        print("Fetching jugador data for userId: \(userId)")
        let jugadorUrl = "https://localhost:3443/jugadores/singlebyuser/\(userId)"
        APIService.shared.fetchJugador(url: jugadorUrl) { result in
            switch result {
            case .success(let jugador):
                print("Jugador fetched: \(jugador)")
                let equipoId = jugador.id_equipo
                let equipoUrl = "https://localhost:3443/equipos/single/\(equipoId)"
                APIService.shared.fetchEquipo(url: equipoUrl) { equipoResult in
                    switch equipoResult {
                    case .success(let equipo):
                        print("Equipo fetched: \(equipo)")
                        self.equipo = equipo
                        fetchJugadores(equipoId: equipoId)
                    case .failure(let error):
                        print("Error fetching equipo: \(error.localizedDescription)")
                        self.errorMessage = error.localizedDescription
                    }
                }
            case .failure(let error):
                print("Error fetching jugador: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
            }
        }
    }

    private func fetchJugadores(equipoId: Int) {
        let url = "https://localhost:3443/jugadores/equipo/\(equipoId)"
        print("Fetching jugadores for equipoId: \(equipoId)")
        APIService.shared.fetchJugadores(url: url) { result in
            switch result {
            case .success(let jugadores):
                print("Jugadores fetched: \(jugadores)")
                self.jugadores = jugadores
            case .failure(let error):
                print("Error fetching jugadores: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

struct EquipoView_Previews: PreviewProvider {
    static var previews: some View {
        EquipoView().environmentObject(UserViewModel())
    }
}
