//
//  GuestView.swift
//  RetoIOS
//
//  Created by Gael Gaytan on 03/05/24.
//

import SwiftUI

struct GuestView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.blue)
                        .padding()
                    }
                    Spacer()
                }
                .padding(.top, 20) // Ajuste de la distancia desde la parte superior
                .padding(.leading, 5)
                
                Text("Vista para continuar como invitado")
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    GuestView()
}
