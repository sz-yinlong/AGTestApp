//
//  PhotoViewModel.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import UIKit

final class ViewModel {
    private let networkManager: NetworkManager
    var photos: [Photo] = []
    private var imageCache = [String: UIImage]()

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    // MARK: - Fetch Photos

    func fetchPhotos(completion: @escaping () -> Void) {
        networkManager.getPhotos { [weak self] fetchedPhotos, _ in
            if let fetchedPhotos = fetchedPhotos {
                self?.photos = fetchedPhotos
            }
            completion()
        }
    }

    // MARK: - Cell Config

    func configureCell(_ cell: CellView, at indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        cell.titleLabel.text = photo.title

        if let cachedImage = imageCache[photo.url] {
            cell.photoImageView.image = cachedImage
        } else {
            networkManager.downloadImage(from: photo.url) { [weak self] image in
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                    if image != nil {
                        self?.imageCache[photo.url] = image
                    }
                }
            }
        }
    }

    // MARK: - Fetch Single Photo

    func fetchSinglePhoto(for photo: Photo, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache[photo.url] {
            completion(cachedImage)
        } else {
            networkManager.downloadImage(from: photo.url) { [weak self] image in
                DispatchQueue.main.async {
                    if let image = image {
                        self?.imageCache[photo.url] = image
                    }
                    completion(image)
                }
            }
        }
    }
}
