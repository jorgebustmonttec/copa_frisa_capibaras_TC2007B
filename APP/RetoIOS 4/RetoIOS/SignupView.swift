//
//  SignupView.swift
//  RetoIOS
//
//  Created by Gael Gaytan on 03/05/24.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                    }
                    Spacer()
                }
                
                HStack {
                    Text("Copa Frisa")
                        .font(.title)
                        .fontWeight(.bold)
                    Image("copa")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 80)
                        .padding()
                }
                VStack(spacing: 20) {
                    Text("Ingrese sus datos")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    TextField("Usuario", text: $username)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    SecureField("Confirmar Contraseña", text: $confirmPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                    
                    TextField("Correo", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    Button(action: {
                        // Acción para crear la cuenta
                    }) {
                        Text("Crear cuenta")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 30)
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}



#Preview {
    SignupView()
}
