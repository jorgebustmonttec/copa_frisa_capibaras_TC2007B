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
                        Spacer(minLength: 20)
                        
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
                    Text("No eres un jugador, pero puedes buscar otros jugadores.")
                        .padding()
                    NavigationLink(destination: BusquedaView()) {
                        Text("Ir a Buscar")
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
                Text("No has iniciado sesion.")
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
