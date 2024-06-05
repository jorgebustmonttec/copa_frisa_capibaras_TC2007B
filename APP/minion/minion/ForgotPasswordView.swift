//
//  ForgotPasswordView.swift
//  App
//
//  Created by Miguel Ponce on 04/06/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var isShowingConfirmation: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Recuperar Contraseña")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)

                Text("Ingresa tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.")
                    .multilineTextAlignment(.center)
                    .padding()

                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                Button("Enviar") {
                    // Lógica para manejar la recuperación de contraseña
                    isShowingConfirmation = true
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                Spacer()
            }
            .navigationBarTitle("Recuperar Contraseña", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancelar") {
                presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $isShowingConfirmation) {
                Alert(
                    title: Text("Correo Enviado"),
                    message: Text("Revisa tu bandeja de entrada para instrucciones de cómo restablecer tu contraseña."),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
