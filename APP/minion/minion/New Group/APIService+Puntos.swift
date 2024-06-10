//
//  APIService+Puntos.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import Foundation

extension APIService {
    func fetchGoals(url: String, completion: @escaping (Result<APIGoals, APIError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            do {
                let goals = try JSONDecoder().decode(APIGoals.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(goals))
                }
            } catch {
                completion(.failure(.decodingFailed("Failed to decode goals response.")))
            }
        }
        task.resume()
    }

    func fetchTotalGreenCards(url: String, completion: @escaping (Result<APIGreenCards, APIError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession(configuration: .default, delegate: SelfSignedCertificateDelegate(), delegateQueue: nil)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            do {
                let greenCards = try JSONDecoder().decode(APIGreenCards.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(greenCards))
                }
            } catch {
                completion(.failure(.decodingFailed("Failed to decode green cards response.")))
            }
        }
        task.resume()
    }
}
