//
//  PhotoViewModel.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import Foundation

final class ViewModel {
    private let networkManager: NetworkManager
    var photos: [Photo] = []

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func fetchPhotos(completion: @escaping () -> Void) {
        networkManager.getPhotos { [weak self] fetchedPhotos, _ in
            if let fetchedPhotos = fetchedPhotos {
                self?.photos = fetchedPhotos
            }
            completion()
        }
    }
}
