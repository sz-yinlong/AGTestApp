//
//  NetworkManager.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    lazy var baseURL: URL? = URL(string: "https://jsonplaceholder.typicode.com")

    func getPhotos(completion: @escaping ([Photo]?, Error?) -> Void) {
        guard let url = baseURL?.appendingPathComponent("/photos") else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "", code: -1, userInfo: nil))
                return
            }
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                completion(photos, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}
