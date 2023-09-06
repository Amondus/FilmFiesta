//
//  ProfileFactory.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import UIKit

final class ProfileFactory {
    func create() -> UIViewController {
        let router = ProfileRouter()
        let viewModel = ProfileViewModel(router: router)
        let controller = ProfileViewController(viewModel: viewModel)
        
        viewModel.view = controller
        router.rootController = controller
        
        return UINavigationController(rootViewController: controller)
    }
}
