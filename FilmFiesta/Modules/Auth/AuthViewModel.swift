//
//  AuthViewModel.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.08.2023.
//

import Foundation
import Firebase
import GoogleSignIn

protocol AuthViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class AuthViewModel {
    weak var view: AuthViewProtocol?
    
    private let router: AuthRouterProtocol
    private let deeplinkVideoId: String?
    
    init(
        router: AuthRouterProtocol,
        deeplinkVideoId: String?
    ) {
        self.router = router
        self.deeplinkVideoId = deeplinkVideoId
    }
}

// MARK: - AuthViewModelProtocol

extension AuthViewModel: AuthViewModelProtocol {
    func viewLoaded() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        view?.update(
            with: .init(
                onLogin: { [weak self] in self?.firebaseLogin() }
            )
        )
    }
}

// MARK: - Private Methods

private extension AuthViewModel {
    func firebaseLogin() {        
        guard let view else { return }

        GIDSignIn.sharedInstance.signIn(withPresenting: view) { [weak self] result, error in
            if let error {
                print("Ошибка аутентификации через Google: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error {
                    print("Ошибка аутентификации через Google: \(error.localizedDescription)")
                    return
                }
                
                guard let self else { return }
                
                self.router.showTabBar(deeplinkVideoId: self.deeplinkVideoId)
            }
        }
    }
}
