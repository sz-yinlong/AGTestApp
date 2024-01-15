//  LoginView.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import SnapKit
import UIKit

// MARK: - Protocol

protocol LoginViewDelegate: AnyObject {
    func loginButtonTapped(withUsername username: String?, password: String?)
}

// MARK: - Class

final class LoginView: UIView {
    weak var delegate: LoginViewDelegate?

    private lazy var authLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.auth
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.enter, for: .normal)
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()

    private lazy var loginTextField: UITextField = createTextField(placeholder: Constants.login, isSecure: false)
    private lazy var passwordTextField: UITextField = createTextField(placeholder: Constants.password, isSecure: true)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .systemBackground
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleLoginButton() {
        delegate?.loginButtonTapped(
            withUsername: loginTextField.text,
            password: passwordTextField.text)
    }

    private func setupView() {
        addSubview(authLabel)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        makeConstraints()
    }

    // MARK: - Constraints

    private func makeConstraints() {
        authLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(Constants.mainOffset)
        }

        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(authLabel.snp.bottom).offset(Constants.topOffset)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.textfieldVertical)
            make.trailing.equalToSuperview().inset(Constants.textfieldVertical)
            make.height.equalTo(Constants.textFieldHeight)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(Constants.passwordTextFieldTopOffset)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.textfieldVertical)
            make.trailing.equalToSuperview().inset(Constants.textfieldVertical)
            make.height.equalTo(Constants.textFieldHeight)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Constants.topOffset)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Extension

extension LoginView {
    private func createTextField(placeholder: String, isSecure: Bool) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        textField.borderStyle = .roundedRect
        return textField
    }
}

extension LoginView {
    private enum Constants {
        static let textFieldHeight: CGFloat = 50
        static let mainOffset: CGFloat = -200
        static let topOffset: CGFloat = 20
        static let textfieldVertical: CGFloat = 70
        static let passwordTextFieldTopOffset: CGFloat = 10

        static let login: String = "Логин"
        static let auth: String = "Авторизация"
        static let password: String = "Пароль"
        static let enter: String = "Войти"
    }
}
