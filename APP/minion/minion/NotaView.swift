//
//  NotaView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import SwiftUI

struct NotaView: View {
    var nota: Nota  // Suponiendo que `Nota` es un modelo que incluye todos los detalles necesarios

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(nota.titulo)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Fecha: \(nota.fecha, formatter: dateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Image(nota.imagen)
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Text(nota.mensaje)
                    .padding(.top, 5)

                HStack {
                    Text("❤️ \(nota.likes)  ✉️ \(nota.comentarios)")
                    Spacer()
                }
                .padding(.vertical)

                Text("Que bonito!")
                    .italic()
            }
            .padding()
        }
        .navigationBarTitle("Detalle", displayMode: .inline)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }
}

// Modelo de datos para Nota
struct Nota {
    var titulo: String
    var fecha: Date
    var imagen: String
    var mensaje: String
    var likes: Int
    var comentarios: Int
}
