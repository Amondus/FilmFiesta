//
//  PlayerContainerView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.06.2023.
//

import UIKit
import SnapKit
import YouTubeiOSPlayerHelper

final class PlayerContainerView: UIView {
    // MARK: - UI Components
    
    private let shortsPlayerView = CustomPlayerView()
    private let playerActionsView = PlayerActionsStackView()
    private let playerBottomView = PlayerBottomView()
    
    private var model: Model?
    private var isDescriptionExpanded = false
    
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
    
    func update(with model: PlayerContainerView.Model) {
        self.model = model
        
        shortsPlayerView.update(with: .init(
            video: model.video,
            playerVars: model.playerVars
        ))

        playerActionsView.update(with: .init(
            favouriteButtonState: model.favouriteButtonState,
            onFavouriteAction: model.onFavouriteAction,
            onShareAction: model.onShareAction,
            onOnlineCinemaAction: model.onOnlineCinemaAction
        ))
        
        playerBottomView.update(with: .init(video: model.video))
    }
    
    func showExpandDescriptionButton() {
        playerBottomView.showExpandDescriptionButton()
    }
    
    func resumeVideo() {
        shortsPlayerView.resumeVideo()
    }
    
    func pauseVideo() {
        shortsPlayerView.pauseVideo()
    }
}

// MARK: - Private Methods

private extension PlayerContainerView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupUI()
    }
    
    func setupSubviews() {
        [shortsPlayerView,
         playerActionsView,
         playerBottomView
        ].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        shortsPlayerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        playerActionsView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(playerBottomView.snp.top).offset(-8)
        }
        
        playerBottomView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-18)
        }
    }
    
    func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if isDescriptionExpanded {
            playerBottomView.hideExpandDescriptionButton()
        } else {
            playerBottomView.showExpandDescriptionButton()
        }
    }
}

// MARK: - Model

extension PlayerContainerView {
    struct Model {
        let video: Video
        let isFirstVideo: Bool
        let favouriteButtonState: Bool
        let playerVars: [String: Any]
        
        let onShowNextVideo: () -> Void
        let onShowPreviousVideo: () -> Void

        let onFavouriteAction: () -> Void
        let onShareAction: () -> Void
        let onOnlineCinemaAction: () -> Void
    }
}
