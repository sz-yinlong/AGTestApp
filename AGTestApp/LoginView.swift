//  LoginView.swift
//  AGTestApp
//
//  Created by Artem on 15.01.2024.
//

import SnapKit
import UIKit

final class LoginView: UIView {
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Войти"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    private lazy var loginTextField: UITextField = createTextField(placeholder: "Логин", isSecure: false)
    private lazy var passwordTextField: UITextField = createTextField(placeholder: "Пароль", isSecure: true)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .systemBackground
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(loginLabel)
        addSubview(loginTextField)
        addSubview(passwordTextField)
        makeConstraints()
    }

    // MARK: - Constraints

    private func makeConstraints() {
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(Constants.topOffset)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.textFieldVerical)
            make.trailing.equalToSuperview().inset(Constants.textFieldVerical)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(Constants.passwordTextFieldTopOffset)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.textFieldVerical)
            make.trailing.equalToSuperview().inset(Constants.textFieldVerical)
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
        static let topOffset: CGFloat = 20
        static let textFieldVerical: CGFloat = 70
        static let passwordTextFieldTopOffset: CGFloat = 10
    }
}
