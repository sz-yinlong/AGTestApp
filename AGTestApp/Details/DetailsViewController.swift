//
//  DetailViewController.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    var photo: Photo?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(titleLabel)

        makeConstraints()
        configureView()
    }

    // MARK: - Constraints

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }

    private func configureView() {
        titleLabel.text = photo?.title
        if let urlString = photo?.url, let _ = URL(string: urlString) {
            NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
}
