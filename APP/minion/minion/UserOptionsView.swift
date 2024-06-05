//
//  UserOptionsView.swift
//  minion
//
//  Created by Jorge Bustamante on 05/06/24.
//
import SwiftUI

struct UserOptionsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if userViewModel.isLoggedIn {
                Text("User ID: \(userViewModel.userId ?? 0)")
                Text("User Type: \(userViewModel.userType ?? 0)")
                Button(action: {
                    userViewModel.logout()
                }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding()
            } else {
                Text("You are not logged in.")
                    .padding()
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss current view
                }) {
                    NavigationLink(destination: ContentView().navigationBarHidden(true)) {
                        Text("Go to Login")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("User Options")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
        .onReceive(userViewModel.$isLoggedIn) { isLoggedIn in
            if isLoggedIn {
                errorMessage = ""
                showAlert = false
            }
        }
    }
}

struct UserOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        UserOptionsView().environmentObject(UserViewModel())
    }
}
