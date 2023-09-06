//
//  ProfileRouter.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func logout()
}

final class ProfileRouter {
    weak var rootController: UIViewController?
}

// MARK: - ProfileRouterProtocol

extension ProfileRouter: ProfileRouterProtocol {
    func logout() {
        let controller = AuthFactory().create(with: .init(deeplinkVideoId: nil))
        UIApplication.shared.windows.first?.rootViewController = controller
    }
}
