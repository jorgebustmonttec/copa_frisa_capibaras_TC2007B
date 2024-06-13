//
//  SignupView.swift
//  App
//
//  Created by Miguel Ponce on 04/06/24.
//
import SwiftUI

struct SignupView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
 
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                    .padding()
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
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(.none)
                        .keyboardType(.asciiCapable)

                    SecureField("Confirmar Contraseña", text: $confirmPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(.none)
                        .keyboardType(.asciiCapable)
                    
                    TextField("Correo", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)

                    Button(action: {
                        signUp()
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Signup"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    
    
    private func signUp() {
        guard !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty, !email.isEmpty else {
            alertMessage = "Todos los campos son requeridos."
            showAlert = true
            return
        }
        
        guard password == confirmPassword else {
            alertMessage = "Las contraseñas no son iguales."
            showAlert = true
            return
        }
        
        guard isValidEmail(email) else {
            alertMessage = "El correo no es válido."
            showAlert = true
            return
        }
        
        guard isValidPassword(password) else {
            alertMessage = "La contraseña debe tener al menos 8 caracteres, incluir un número, un carácter especial y no ser igual al nombre de usuario."
            showAlert = true
            return
        }
        
        APIService.shared.signup(username: username, displayName: username, email: email, password: password) { result in
            switch result {
            case .success(let response):
                alertMessage = response.message ?? "Cuenta de usuario creada exitosamente"
                showAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    presentationMode.wrappedValue.dismiss()
                }
            case .failure(let error):
                switch error {
                case .serverError(let message):
                    alertMessage = message
                case .decodingFailed(let message):
                    alertMessage = message
                default:
                    alertMessage = "Error en el servidor."
                }
                showAlert = true
            }
        }
    }

    
    private func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordFormat = "^(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: password) && password != username
    }
}

#Preview {
    SignupView()
}
