//
//  TabBarController.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 11.06.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Parameters
    
    private let deeplinkVideoId: String?
    
    // MARK: - Initialization
    
    init(deeplinkVideoId: String? = nil) {
        self.deeplinkVideoId = deeplinkVideoId
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .white
        viewControllers = getControllers()
    }
}

// MARK: - Private Methods

private extension TabBarController {
    func getControllers() -> [UIViewController] {
        let controller1 = CarouselFactory().create(with: .init(deeplinkVideoId: deeplinkVideoId))
        controller1.tabBarItem = UITabBarItem(
            title: "Поиск",
            image: UIImage(named: "search_icon"),
            tag: 0
        )
        
        let controller2 = FavouritesFactory().create()
        controller2.tabBarItem = UITabBarItem(
            title: "Избранное",
            image: UIImage(named: "heart_icon"),
            tag: 1
        )

        let controller3 = ProfileFactory().create()
        controller3.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person"),
            tag: 2
        )
        
        return [controller1, controller2, controller3]
    }
}
