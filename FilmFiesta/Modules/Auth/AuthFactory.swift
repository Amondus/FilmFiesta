//
//  AuthFactory.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import UIKit

final class AuthFactory {
    func create(with context: Context) -> UIViewController {
        let router = AuthRouter()
        let viewModel = AuthViewModel(
            router: router,
            deeplinkVideoId: context.deeplinkVideoId
        )

        let controller = AuthViewController(viewModel: viewModel)
        
        viewModel.view = controller
        router.rootController = controller
        
        return controller
    }
}

// MARK: - Context

extension AuthFactory {
    struct Context {
        let deeplinkVideoId: String?
    }
}
