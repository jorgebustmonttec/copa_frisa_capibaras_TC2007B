//
//  JugadorView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import SwiftUI

struct JugadorView: View {
    var jugador: Jugador
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Título y Foto (Si la foto del jugador no está disponible, usar un icono genérico)
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .padding(.top, 20)
                        .foregroundColor(.black)  // Ajustar el color según la temática del equipo
                
                    VStack(alignment: .leading) {
                        Text(jugador.nombre)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Perfil de \(jugador.nombre)")
                            .font(.title2)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)

                Divider()

                // Sección de Detalles con iconos
                Group {
                    DetailView(icon: "figure.soccer", title: "Posición", detail: jugador.posicion)
                    DetailView(icon: "soccerball", title: "Goles totales", detail: "\(jugador.numeroGoles)")
                    DetailView(icon: "rectangle.stack.person.crop", title: "Tarjetas acumuladas", detail: "\(jugador.tarjetas)")
                }
                .padding([.horizontal, .bottom])
            }
            .padding(.top)
        }
        .background(Color(.systemGroupedBackground)) // Un fondo suave para toda la vista
        .navigationBarTitle("Perfil de \(jugador.nombre)", displayMode: .inline)
    }
}

// Vista para representar cada detalle con un icono
struct DetailView: View {
    var icon: String
    var title: String
    var detail: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)  // Ajustar según el esquema de colores del equipo
                .frame(width: 30, height: 30)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(detail)
                    .font(.title3)
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, 5)
    }
}

struct JugadorView_Previews: PreviewProvider {
    static var previews: some View {
        JugadorView(jugador: Jugador(nombre: "José", posicion: "Delantero", numeroGoles: 5, tarjetas: 1))
    }
}

