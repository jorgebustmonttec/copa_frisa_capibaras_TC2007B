//
//  APIService+Partido.swift
//  minion
//
//  Created by Jorge Bustamante on 09/06/24.
//
import Foundation

extension APIService {
    func fetchPartidos(url: String, completion: @escaping (Result<[APIPartido], APIError>) -> Void) {
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
                let partidos = try JSONDecoder().decode([APIPartido].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(partidos))
                }
            } catch {
                completion(.failure(.decodingFailed("Failed to decode partidos response.")))
            }
        }
        task.resume()
    }

    func fetchLastGameInfo(url: String, completion: @escaping (Result<APILastGameInfo, APIError>) -> Void) {
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
                let lastGameInfo = try JSONDecoder().decode(APILastGameInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(lastGameInfo))
                }
            } catch {
                completion(.failure(.decodingFailed("Failed to decode last game info response.")))
            }
        }
        task.resume()
    }
}
