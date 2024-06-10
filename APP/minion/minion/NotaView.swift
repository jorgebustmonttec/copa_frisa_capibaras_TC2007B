//
//  NotaView.swift
//  App
//
//  Created by Miguel Ponce on 16/05/24.
//
import SwiftUI

struct NotaView: View {
    var title: String
    var image: Image?
    var message: String
    var date: String
    var author: String

    var body: some View {
        ScrollView{
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                if let image = image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .padding()
                }
                
                HStack {
                    Text(date)
                        .font(.subheadline)
                    Text("•")
                        .font(.subheadline)
                    Text(author)
                        .font(.subheadline)
                        .bold()
                }
                .padding(.bottom, 10)
                
                Text(message)
                    .font(.body)
                    .padding()
                
                Spacer()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .padding()
    }
}

struct NotaView_Previews: PreviewProvider {
    static var previews: some View {
        NotaView(title: "Titulo Ejemplo", image: nil, message: "Detalles del ejemplo aquí", date: "2024-06-08", author: "admin")
    }
}
