//
//  ViewController.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    private var viewModel: ViewModel
    private let maxPhotoCount = 100

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .orange
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActivityIndicator()
        loadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(viewModel.photos.count, maxPhotoCount)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? CellView else {
            fatalError("PhotoCell not found")
        }
        let photo = viewModel.photos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = viewModel.photos[indexPath.row]
        let detailVC = DetailsViewController()
        detailVC.photo = photo
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController {
    private func setupTableView() {
        tableView.register(CellView.self, forCellReuseIdentifier: "PhotoCell")
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    private func loadData() {
        viewModel.fetchPhotos { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
