//
//  LoginViewController.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    private let loginView = LoginView()
    weak var delegate: LoginViewDelegate?

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.delegate = self
    }
}

extension LoginViewController: LoginViewDelegate {
    func loginButtonTapped(withUsername username: String?, password: String?) {
        guard let username = username, let password = password,
              username == "1234", password == "1234"
        else {
            return
        }
        let networkManager = NetworkManager()
        let viewModel = ViewModel(networkManager: networkManager)
        let mainViewController = MainViewController(viewModel: viewModel)

        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}
