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

    var nombre: String = "Nombre Jugador"
    var equipo: String = "Equipo"
    var goles: Int = 7
    var posicion: String = "Delantero"
    var tarjetas: Int = 5
    var ultimoJuegoFecha: String = "1/12/24"
    var ultimoJuegoResultado: String = "5 - 2"

    var body: some View {
        if userViewModel.isLoggedIn {
            if userViewModel.userType == 1 {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        // Espacio en la parte superior
                        Spacer(minLength: 20)
                        
                        // Sección del nombre y foto
                        HStack(spacing: 16) {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                            
                            VStack(alignment: .leading) {
                                Text(nombre)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text(equipo)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }

                        Divider()
                        
                        // Estadísticas con un estilo más limpio
                        Group {
                            StatisticView(label: "Goles", value: String(goles))
                            StatisticView(label: "Posición", value: posicion)
                            StatisticView(label: "Tarjetas Verdes", value: String(tarjetas))
                            StatisticView(label: "Último Juego", value: ultimoJuegoFecha)
                            StatisticView(label: "Resultado", value: ultimoJuegoResultado)
                        }
                        .padding(.vertical, 2)
                    }
                    .padding()
                }
                .navigationBarTitle("Perfil del Jugador", displayMode: .inline)
            } else {
                VStack {
                    Text("You are not a player, but you can look up other players.")
                        .padding()
                    NavigationLink(destination: BusquedaView()) {
                        Text("Go to Search")
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
                Text("You are not logged in.")
                    .padding()
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss current view
                }) {
                    NavigationLink(destination: ContentView().navigationBarHidden(true)) {
                        Text("Go to Login")
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
}

// Vista auxiliar para mostrar estadísticas
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
