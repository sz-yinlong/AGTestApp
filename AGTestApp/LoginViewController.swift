//
//  LoginViewController.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import UIKit

final class LoginViewController: UIViewController {
    private let loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
