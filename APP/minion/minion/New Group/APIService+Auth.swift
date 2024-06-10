//
//  APIService+Auth.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import Foundation

extension APIService {
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/usuarios/login") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["username": username, "password": password] // Corrected line
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(loginResponse))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode successful login response.")))
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.failure(.decodingFailed(errorResponse.message)))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode error response.")))
                }
            }
        }
        task.resume()
    }

    func signup(username: String, displayName: String, email: String, password: String, completion: @escaping (Result<SignupResponse, APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/usuarios/signup") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["username": username, "display_name": displayName, "correo": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                do {
                    let signupResponse = try JSONDecoder().decode(SignupResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(signupResponse))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode successful signup response.")))
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(SignupResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.failure(.decodingFailed(errorResponse.error ?? "Unknown error")))
                    }
                } catch {
                    completion(.failure(.decodingFailed("Failed to decode error response.")))
                }
            }
        }
        task.resume()
    }

    func changePassword(userId: Int, newPassword: String, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/usuarios/changePassword") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["userId": userId, "newPassword": newPassword]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed))
                return
            }

            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(.requestFailed))
            }
        }
        task.resume()
    }
}
