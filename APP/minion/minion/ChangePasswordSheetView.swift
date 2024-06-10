//
//  ChangePasswordSheetView.swift
//  minion
//
//  Created by Jorge Bustamante on 08/06/24.
//
import SwiftUI

struct ChangePasswordSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            Text("Cambio de Contraseña")
                .font(.title)
                .padding()

            SecureField("Contraseña Actual", text: $currentPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)

            SecureField("Nueva Contraseña", text: $newPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)

            SecureField("Confirmar Nueva Contraseña", text: $confirmPassword)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                changePassword()
            }) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Cambiar Contraseña")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }

    private func changePassword() {
        guard !newPassword.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Todos los campos son obligatorios"
            return
        }

        guard newPassword == confirmPassword else {
            errorMessage = "Las nuevas contraseñas no coinciden"
            return
        }

        guard newPassword != currentPassword else {
            errorMessage = "La nueva contraseña debe ser diferente a la actual"
            return
        }

        isLoading = true
        errorMessage = ""

        APIService.shared.changePassword(userId: userViewModel.userId!, newPassword: newPassword) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    self.userViewModel.isLoggedIn = true
                    self.presentationMode.wrappedValue.dismiss()
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct ChangePasswordSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordSheetView().environmentObject(UserViewModel())
    }
}