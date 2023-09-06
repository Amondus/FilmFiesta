//
//  ProfileViewModel.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import Foundation
import Firebase

protocol ProfileViewModelProtocol: AnyObject {
    func viewLoaded()
    func logout()
}

final class ProfileViewModel {
    weak var view: ProfileViewProtocol?
    
    private let router: ProfileRouterProtocol
    
    init(router: ProfileRouterProtocol) {
        self.router = router
    }
}

// MARK: - ProfileViewModelProtocol

extension ProfileViewModel: ProfileViewModelProtocol {
    func viewLoaded() {
        let user = Auth.auth().currentUser
        
        view?.update(
            with: .init(
                name: user?.displayName,
                email: user?.email,
                userId: user?.uid,
                profileImageUrl: user?.photoURL
            )
        )
    }
    
    func logout() {
        firebaseLogout()
    }
}

// MARK: - Private Methods

private extension ProfileViewModel {
    func firebaseLogout() {
        let firebaseAuth = Auth.auth()

        do {
            try firebaseAuth.signOut()
            router.logout()
        } catch let error {
            print(error)
        }
    }
}
