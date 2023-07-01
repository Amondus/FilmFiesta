//
//  CarouselViewController.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 29.05.2023.
//

import UIKit

protocol CarouselViewProtocol: AnyObject {
    func update(with model: CarouselView.Model)
}

final class CarouselViewController: UIViewController {
    // MARK: - UIComponents

    private let customView = CarouselView()
    
    // MARK: - Parameters

    private let viewModel: CarouselViewModelProtocol
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: - Initialization
    
    init(viewModel: CarouselViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewLoaded()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView.resumeVideo()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        customView.pauseVideo()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }
}

// MARK: - Private Methods

private extension CarouselViewController {
    func addObservers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(appBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self, selector: #selector(appMovedToBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )

        NotificationCenter.default.removeObserver(
            self,
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
    }
    
    @objc
    func appBecomeActive() {
        customView.resumeVideo()
    }
    
    @objc
    func appMovedToBackground() {
        customView.pauseVideo()
    }
}

// MARK: - CarouselViewProtocol

extension CarouselViewController: CarouselViewProtocol {
    func update(with model: CarouselView.Model) {
        customView.update(with: model)
    }
}
