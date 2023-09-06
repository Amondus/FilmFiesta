//
//  ProfileViewController.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import UIKit

protocol ProfileViewProtocol: UIViewController {
    func update(with model: ProfileView.Model)
}

final class ProfileViewController: UIViewController {
    // MARK: - UIComponents

    private let customView = ProfileView()
    
    // MARK: - Parameters

    private let viewModel: ProfileViewModelProtocol
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: - Initialization
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confugureNavigationBar()
        viewModel.viewLoaded()
    }
}

// MARK: - Private Methods

private extension ProfileViewController {
    func confugureNavigationBar() {
        title = "Профиль"

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Выйти",
            style: .plain,
            target: self,
            action: #selector(logout)
        )
        
        navigationItem.rightBarButtonItem?.tintColor = .init(named: "brandPink_color")
    }

    @objc
    func logout() {
        viewModel.logout()
    }
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func update(with model: ProfileView.Model) {
        customView.update(with: model)
    }
}
