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
    @Published var firstLogin: Bool = false
    
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
    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        APIService.shared.login(username: username, password: password) { result in
            switch result {
            case .success(let response):
                self.userId = response.userId
                self.userType = response.userType
                UserDefaults.standard.set(response.userId, forKey: "userId")
                UserDefaults.standard.set(response.userType, forKey: "userType")
                
                if response.userType == 2 {
                    self.fetchUserDetails(userId: response.userId!) { result in
                        switch result {
                        case .success(let userDetails):
                            self.firstLogin = userDetails.first_login == 1
                            completion(.success(response))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    self.isLoggedIn = true
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    completion(.success(response))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUserDetails(userId: Int, completion: @escaping (Result<UserDetails, APIError>) -> Void) {
        APIService.shared.fetchUserDetails(userId: userId, completion: completion)
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
