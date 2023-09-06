//
//  AuthViewController.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import UIKit

protocol AuthViewProtocol: UIViewController {
    func update(with model: AuthView.Model)
}

final class AuthViewController: UIViewController {
    // MARK: - UIComponents

    private let customView = AuthView()
    
    // MARK: - Parameters

    private let viewModel: AuthViewModelProtocol
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: - Initialization
    
    init(viewModel: AuthViewModelProtocol) {
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
        viewModel.viewLoaded()
    }
}

// MARK: - AuthViewProtocol

extension AuthViewController: AuthViewProtocol {
    func update(with model: AuthView.Model) {
        customView.update(with: model)
    }
}
