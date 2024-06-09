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

    let nombreEquipo: String = "Nombre de Equipo"
    let jugadores: [Jugador] = [
        Jugador(nombre: "Jose", posicion: "Delantero", numeroGoles: 5, tarjetas: 1),
        Jugador(nombre: "Juan Luis", posicion: "Mediocampista", numeroGoles: 3, tarjetas: 0),
        Jugador(nombre: "Pedro", posicion: "Defensa", numeroGoles: 1, tarjetas: 2),
        Jugador(nombre: "Alonso", posicion: "Portero", numeroGoles: 0, tarjetas: 1)
    ]

    var body: some View {
        if userViewModel.isLoggedIn {
            if userViewModel.userType == 2 {
                NavigationView {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "shield.lefthalf.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading) {
                                Text(nombreEquipo)
                                    .font(.title)
                                    .bold()
                                Text("Escuela")
                                    .font(.subheadline)
                                Text("Patrocinador")
                                    .font(.subheadline)
                            }
                        }

                        Text("Jugadores")
                            .font(.headline)

                        List(jugadores, id: \.id) { jugador in
                            NavigationLink(destination: JugadorView(jugador: jugador)) {
                                Text(jugador.nombre)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .navigationBarTitle("Detalles del Equipo", displayMode: .inline)
                }
            } else {
                VStack {
                    Text("No eres un jugador, pero puedes buscar otros equipos.")
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
}

struct EquipoView_Previews: PreviewProvider {
    static var previews: some View {
        EquipoView().environmentObject(UserViewModel())
    }
}

#Preview {
    EquipoView()
}
