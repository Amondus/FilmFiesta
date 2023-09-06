//
//  AuthRouter.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import UIKit

protocol AuthRouterProtocol: AnyObject {
    func showTabBar(deeplinkVideoId: String?)
}

final class AuthRouter {
    weak var rootController: UIViewController?
}

// MARK: - AuthRouterProtocol

extension AuthRouter: AuthRouterProtocol {
    func showTabBar(deeplinkVideoId: String?) {
        let controller = TabBarController(deeplinkVideoId: deeplinkVideoId)
        UIApplication.shared.windows.first?.rootViewController = controller
    }
}
