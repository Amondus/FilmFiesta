//
//  AuthView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import UIKit
import GoogleSignIn
import SnapKit

final class AuthView: UIView {
    // MARK: - UI Components
    
    private let appLabel = UILabel()
    private let authLabel = UILabel()
    private let appImageView = UIImageView()
    private let backgroundImageView = UIImageView()
    private let googleSignInButton = GIDSignInButton()
    
    // MARK: - Parameters
    
    private var model: Model?
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func update(with model: AuthView.Model) {
        self.model = model
    }
}

// MARK: - Private Methods

private extension AuthView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupUI()
        setupAppLabel()
        setupAuthLabel()
        setupImageView()
        setupLoginButton()
    }
    
    func setupSubviews() {
        [backgroundImageView,
         googleSignInButton,
         appImageView,
         appLabel,
         authLabel
        ].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        appImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        appLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview().offset(-150)
        }

        authLabel.snp.makeConstraints { make in
            make.top.equalTo(appLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        googleSignInButton.snp.makeConstraints { make in
            make.top.equalTo(authLabel.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(50)
        }
    }
    
    func setupUI() {
        backgroundColor = UIColor(named: "loadingPlayer_color")
        backgroundImageView.image = UIImage(named: "favouritePlaceholder_image")
    }
    
    func setupAppLabel() {
        appLabel.font = UIFont.systemFont(ofSize: 38, weight: .semibold)
        appLabel.numberOfLines = 0
        appLabel.textAlignment = .center
        appLabel.text = "Film Fiesta"
        appLabel.textColor = .white
    }

    func setupAuthLabel() {
        authLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        authLabel.numberOfLines = 0
        authLabel.textAlignment = .center
        authLabel.text = "Подборки интересных фильмов на каждый вечер"
        authLabel.textColor = .lightGray
    }
    
    func setupImageView() {
        appImageView.image = UIImage(named: "appLogo_icon")
        appImageView.contentMode = .scaleAspectFit
    }
    
    func setupLoginButton() {
        googleSignInButton.style = .wide
        
        googleSignInButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
    }

    @objc
    func loginButtonTapped() {
        model?.onLogin()
    }
}

// MARK: - Model

extension AuthView {
    struct Model {
        var onLogin: (() -> Void)
    }
}
