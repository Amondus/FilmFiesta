//
//  FavouritesViewController.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.06.2023.
//

import UIKit

protocol FavouritesViewProtocol: AnyObject {
    func update(with model: FavouritesView.Model)
}

final class FavouritesViewController: UIViewController {
    // MARK: - UIComponents

    private let customView = FavouritesView()
    
    // MARK: - Parameters

    private let viewModel: FavouritesViewModelProtocol
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: - Initialization
    
    init(viewModel: FavouritesViewModelProtocol) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadFavourites()
    }
}

private extension FavouritesViewController {
    func confugureNavigationBar() {
        title = "Избранное"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(changeTabBarItem)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .init(named: "brandPink_color")
    }

    @objc
    func changeTabBarItem() {
        tabBarController?.selectedIndex = 0
    }
}

// MARK: - FavouritesViewProtocol

extension FavouritesViewController: FavouritesViewProtocol {
    func update(with model: FavouritesView.Model) {
        customView.update(with: model)
    }
}
