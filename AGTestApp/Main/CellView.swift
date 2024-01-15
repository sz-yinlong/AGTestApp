//
//  PhotoCell.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import UIKit

class CellView: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(photoImageView)
        makeConstraints()
    }

    // MARK: - Constraints

    private func makeConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(contentView.snp.top).offset(Constatns.verticalOffset)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).inset(Constatns.verticalOffset)
            make.leading.equalTo(contentView.snp.leading).offset(Constatns.verticalOffset)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(Constatns.photosSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(photoImageView.snp.trailing).offset(Constatns.verticalOffset)
            make.trailing.equalTo(contentView.snp.trailing).inset(Constatns.verticalOffset)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }

    func configure(with photo: Photo) {
        titleLabel.text = photo.title
        NetworkManager.shared.downloadImage(from: photo.url) { [weak self] image in
            DispatchQueue.main.async {
                self?.photoImageView.image = image
            }
        }
    }
}

private extension CellView {
    enum Constatns {
        static let verticalOffset: CGFloat = 10
        static let photosSize: CGFloat = 60
    }
}
