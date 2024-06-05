//
//  UserViewModel.swift
//  apitestswiftui
//
//  Created by Jorge Bustamante on 04/06/24.
//
import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var userId: Int?
    @Published var userType: Int?

    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        self.userId = UserDefaults.standard.integer(forKey: "userId")
        self.userType = UserDefaults.standard.integer(forKey: "userType")

        if userId == 0 {
            self.userId = nil
        }
        if userType == 0 {
            self.userType = nil
        }
    }

    func login(username: String, password: String, completion: @escaping (Result<Void, APIError>) -> Void) {
        APIService.shared.login(username: username, password: password) { result in
            switch result {
            case .success(let response):
                self.userId = response.userId
                self.userType = response.userType
                self.isLoggedIn = true

                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(response.userId, forKey: "userId")
                UserDefaults.standard.set(response.userType, forKey: "userType")

                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func logout() {
        self.isLoggedIn = false
        self.userId = nil
        self.userType = nil

        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userType")
    }
}
