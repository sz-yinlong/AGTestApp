//
//  DetailViewController.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    var photo: Photo?
    var viewModel: ViewModel?

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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.defaultOffset)
            make.leading.equalTo(view.snp.leading).offset(Constants.defaultOffset)
            make.trailing.equalTo(view.snp.trailing).offset(Constants.defaultOffset)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.defaultOffset)
            make.leading.equalTo(view.snp.leading).offset(Constants.defaultOffset)
            make.trailing.equalTo(view.snp.trailing).inset(Constants.defaultOffset)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.defaultOffset)
        }
    }

    private func configureView() {
        titleLabel.text = photo?.title
        if let photo = photo {
            viewModel?.fetchSinglePhoto(for: photo) { [weak self] image in
                self?.imageView.image = image
            }
        }
    }
}

private extension DetailsViewController {
    enum Constants {
        static let defaultOffset: CGFloat = 20
    }
}
