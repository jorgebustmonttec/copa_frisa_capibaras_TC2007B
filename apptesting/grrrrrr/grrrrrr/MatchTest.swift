//
//  NotaView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//

import SwiftUI

struct NotaView: View {
    var title: String
    var imageName: String
    var message: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .shadow(radius: 4)
                .padding()
            
            Text(message)
                .font(.body)
                .padding()

            Spacer()
        }
        .navigationBarTitle(Text(title), displayMode: .inline)
        .padding()
    }
}

struct NotaView_Previews: PreviewProvider {
    static var previews: some View {
        NotaView(title: "Titulo Ejemplo", imageName: "REGLAS", message: "Detalles del ejemplo aquí")
    }
}
