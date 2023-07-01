//
//  PlayerActionsStackView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 11.06.2023.
//

import UIKit
import SnapKit

final class PlayerActionsStackView: UIView {
    // MARK: - UI Components

    private let favouriteView = PlayerActionView()
    private let shareView = PlayerActionView()
    private let onlineCinemaView = PlayerActionView()
    
    private let stackView = UIStackView()
    
    // MARK: - Parameters
    
    private var favouriteButtonState = false
    
    private var model: Model?
    
    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func update(with model: PlayerActionsStackView.Model) {
        self.model = model
        favouriteButtonState = model.favouriteButtonState

        setupFavouriteView()
        setupShareView()
        setupOnlineCinemaView()
    }
}

// MARK: - Private Methods

private extension PlayerActionsStackView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupStackView()
    }

    func setupSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func setupStackView() {
        [favouriteView,
         shareView,
         onlineCinemaView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.spacing = 12
        stackView.axis = .vertical
    }
    
    func setupFavouriteView() {
        guard let defaultImage = UIImage(named: "heart_icon"),
              let filledImage = UIImage(named: "heartFilled_icon")
        else { return }

        favouriteView.update(with: .init(
            image: favouriteButtonState ? filledImage : defaultImage,
            tapAction: { [weak self] in self?.updateFavouriteView() }
        ))
    }
    
    func setupShareView() {
        guard let image = UIImage(named: "share_icon"),
              let model = model
        else { return }

        shareView.update(with: .init(
            image: image,
            tapAction: model.onShareAction
        ))
    }
    
    func setupOnlineCinemaView() {
        guard let image = UIImage(named: "onlineCinema_icon"),
              let model = model
        else { return }

        onlineCinemaView.update(with: .init(
            image: image,
            tapAction: model.onOnlineCinemaAction
        ))
    }
    
    func updateFavouriteView() {
        favouriteButtonState.toggle()
        
        setupFavouriteView()
        model?.onFavouriteAction()
    }
}

// MARK: - Model

extension PlayerActionsStackView {
    struct Model {
        let favouriteButtonState: Bool
        
        let onFavouriteAction: () -> Void
        let onShareAction: () -> Void
        let onOnlineCinemaAction: () -> Void
    }
}
