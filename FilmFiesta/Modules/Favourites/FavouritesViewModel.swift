//
//  FavouritesViewModel.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.06.2023.
//

import Foundation
import RealmSwift

protocol FavouritesViewModelProtocol: AnyObject {
    func loadFavourites()
}

final class FavouritesViewModel {
    weak var view: FavouritesViewProtocol?
    
    private let router: FavouritesRouterProtocol
    
    private var videos: [Video] = []
    private var currentIndex = 0
    
    init(router: FavouritesRouterProtocol) {
        self.router = router
    }
}

// MARK: - FavouritesViewModelProtocol

extension FavouritesViewModel: FavouritesViewModelProtocol {
    func loadFavourites() {
        updateView(with: obtainFavourites())
    }
}

// MARK: - Private Methods

private extension FavouritesViewModel {
    func updateView(with videos: [Video]) {
        view?.update(with: .init(
            videos: videos
        ))
    }
    
    func obtainFavourites() -> [Video] {
        let realm = try? Realm()
        if let array = realm?.objects(Video.self) {
            return Array(array)
        }
        
        return []
    }
}
