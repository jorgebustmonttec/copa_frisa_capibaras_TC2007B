//
//  SheetView.swift
//  minion
//
//  Created by Jorge Bustamante on 08/06/24.
//
import SwiftUI

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        VStack {
            Text("Login Successful")
                .font(.title)
                .padding()
            
            Button("Continue") {
                userViewModel.isLoggedIn = true // Set loggedIn to true here
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView().environmentObject(UserViewModel())
    }
}
