//
//  CarouselRouter.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 29.05.2023.
//

import UIKit

protocol CarouselRouterProtocol: AnyObject {
    func showShareController(activityItems: [Any])
}

final class CarouselRouter {
    weak var rootController: UIViewController?
}

// MARK: - CarouselRouterProtocol

extension CarouselRouter: CarouselRouterProtocol {
    func showShareController(activityItems: [Any]) {
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )

        rootController?.present(activityViewController, animated: true)
    }
}
