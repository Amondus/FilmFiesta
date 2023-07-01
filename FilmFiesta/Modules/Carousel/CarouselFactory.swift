//
//  CarouselFactory.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 29.05.2023.
//

import UIKit

final class CarouselFactory {
    func create(with context: Context) -> UIViewController {
        let router = CarouselRouter()
        let viewModel = CarouselViewModel(
            router: router,
            videoService: VideoServiceMock(),
            deeplinkVideoId: context.deeplinkVideoId
        )

        let controller = CarouselViewController(viewModel: viewModel)
        
        viewModel.view = controller
        router.rootController = controller
        
        return controller
    }
}

// MARK: - Context

extension CarouselFactory {
    struct Context {
        let deeplinkVideoId: String?
    }
}
