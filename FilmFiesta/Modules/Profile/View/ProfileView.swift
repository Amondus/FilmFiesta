//
//  ProfileView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import UIKit
import Kingfisher

final class ProfileView: UIView {
    // MARK: - UI Components
    
    private let profileImageView = UIImageView()
    
    private let profileNameLabel = UILabel()
    private let profileEmailLabel = UILabel()
    private let profileIdLabel = UILabel()
    
    private let profileNameTextField = UITextField()
    private let profileEmailTextField = UITextField()
    private let profileIdTextField = UITextField()
    
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
    
    func update(with model: ProfileView.Model) {
        self.model = model
        
        profileNameTextField.text = model.name
        profileEmailTextField.text = model.email
        profileIdTextField.text = model.userId
        
        updateUserImage(with: model.profileImageUrl)
    }
}

// MARK: - Private Methods

private extension ProfileView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupUI()
        setupProfileImageView()
        setupLabels()
        setupTextFields()
    }
    
    func setupSubviews() {
        [profileImageView,
         profileNameLabel,
         profileEmailLabel,
         profileIdLabel,
         profileNameTextField,
         profileEmailTextField,
         profileIdTextField
        ].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.width.height.equalTo(130)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-24)
        }
        
        profileNameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileNameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        profileEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(profileNameTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-24)
        }
        
        profileEmailTextField.snp.makeConstraints { make in
            make.top.equalTo(profileEmailLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        profileIdLabel.snp.makeConstraints { make in
            make.top.equalTo(profileEmailTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-24)
        }
        
        profileIdTextField.snp.makeConstraints { make in
            make.top.equalTo(profileIdLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
    }
    
    func setupUI() {
        backgroundColor = UIColor(named: "loadingPlayer_color")
    }
    
    func setupProfileImageView() {
        layoutIfNeeded()

        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor(named: "brandPink_color")?.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
    }
    
    func setupLabels() {
        profileNameLabel.text = "Имя пользователя"
        profileNameLabel.textColor = .gray
        
        profileEmailLabel.text = "Email адрес"
        profileEmailLabel.textColor = .gray
        
        profileIdLabel.text = "ID пользователя"
        profileIdLabel.textColor = .gray
    }
    
    func setupTextFields() {
        let backgroundColor = UIColor(named: "brandPink_color")?.withAlphaComponent(0.4)
        
        profileNameTextField.isEnabled = false
        profileNameTextField.placeholder = "Имя пользователя"
        profileNameTextField.borderStyle = .roundedRect
        profileNameTextField.backgroundColor = backgroundColor
        profileNameTextField.textColor = .white
        
        profileEmailTextField.isEnabled = false
        profileEmailTextField.placeholder = "Email адрес"
        profileEmailTextField.borderStyle = .roundedRect
        profileEmailTextField.backgroundColor = backgroundColor
        profileEmailTextField.textColor = .white
        
        profileIdTextField.isEnabled = false
        profileIdTextField.placeholder = "ID пользователя"
        profileIdTextField.borderStyle = .roundedRect
        profileIdTextField.backgroundColor = backgroundColor
        profileIdTextField.textColor = .white
    }
    
    func updateUserImage(with url: URL?) {
        guard let url else { return }
        profileImageView.kf.setImage(with: url)
    }
}

// MARK: - Model

extension ProfileView {
    struct Model {
        let name: String?
        let email: String?
        let userId: String?
        let profileImageUrl: URL?
    }
}

