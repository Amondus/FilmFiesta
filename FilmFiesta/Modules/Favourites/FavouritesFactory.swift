//
//  FavouritesFactory.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.06.2023.
//

import UIKit

final class FavouritesFactory {
    func create() -> UIViewController {
        let router = FavouritesRouter()
        let viewModel = FavouritesViewModel(router: router)
        let controller = FavouritesViewController(viewModel: viewModel)
        
        viewModel.view = controller
        router.rootController = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
