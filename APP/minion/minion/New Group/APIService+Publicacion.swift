//
//  APIService+Publicacion.swift
//  minion
//
//  Created by Jorge Bustamante on 10/06/24.
//

import Foundation

extension APIService {
    func fetchAllPosts(completion: @escaping (Result<[APIPost], APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/publicaciones") else {
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
                let posts = try JSONDecoder().decode([APIPost].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(posts))
                }
            } catch {
                completion(.failure(.decodingFailed("Failed to decode posts response.")))
            }
        }
        task.resume()
    }

    func fetchPostImage(postId: Int, completion: @escaping (Result<Data, APIError>) -> Void) {
        guard let url = URL(string: "https://localhost:3443/publicaciones/\(postId)/imagen") else {
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

            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        task.resume()
    }
}

struct APIPost: Codable, Identifiable {
    var id_post: Int
    var autor: String
    var fecha: String
    var titulo: String
    var contenido: String
    var imagen: String?

    var id: Int { id_post }
}
