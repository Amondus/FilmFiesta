//
//  DeeplinkHandler.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 17.06.2023.
//

import UIKit

protocol DeeplinkHandlerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
}

final class VideoDeeplinkHandler: DeeplinkHandlerProtocol {
    
    private weak var rootViewController: UIViewController?
    
    init(rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - DeeplinkHandlerProtocol
    
    func canOpenURL(_ url: URL) -> Bool {
        return url.absoluteString.hasPrefix("filmfiesta://video/")
    }
    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        
        // mock the navigation
        let viewController = UIViewController()
        switch url.path {
        case "/new":
            viewController.title = "Video Editing"
            viewController.view.backgroundColor = .orange
        default:
            viewController.title = "Video Listing"
            viewController.view.backgroundColor = .cyan
        }
        
        rootViewController?.present(viewController, animated: true)
    }
}
