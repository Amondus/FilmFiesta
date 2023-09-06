//
//  NewCarouselViewv.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 11.06.2023.
//

import UIKit
import SnapKit
import youtube_ios_player_helper

final class CarouselView: UIView {
    // MARK: - UI Components
    
    private let appImageView = UIImageView()
    private let playerContainerView = PlayerContainerView()
    
    private var isDescriptionExpanded = false
    private var viewOffset: CGPoint = .zero
    
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
    
    func update(with model: CarouselView.Model) {
        self.model = model
        
        playerContainerView.update(with: .init(
            video: model.video,
            isFirstVideo: model.isFirstVideo,
            favouriteButtonState: model.favouriteButtonState,
            playerVars: model.playerVars,
            onShowNextVideo: model.onShowNextVideo,
            onShowPreviousVideo: model.onShowPreviousVideo,
            onFavouriteAction: model.onFavouriteAction,
            onShareAction: model.onShareAction,
            onOnlineCinemaAction: model.onOnlineCinemaAction
        ))
    }
    
    func showExpandDescriptionButton() {
        playerContainerView.showExpandDescriptionButton()
    }
    
    func resumeVideo() {
        playerContainerView.resumeVideo()
    }
    
    func pauseVideo() {
        playerContainerView.pauseVideo()
    }
}

// MARK: - Private Methods

private extension CarouselView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupImageView()
        setupPlayerContainerView()
    }
    
    func setupSubviews() {
        [playerContainerView,
         appImageView
        ].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        playerContainerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }

        appImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
        }
    }

    func setupImageView() {
        appImageView.image = UIImage(named: "appLogo_icon")
        appImageView.contentMode = .scaleAspectFit
    }
    
    func setupPlayerContainerView() {
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipe(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: playerContainerView)
        let progress = translation.y / playerContainerView.bounds.height
        let isFirstVideo = model?.isFirstVideo ?? true
        let isLastVideo = model?.isLastVideo ?? false
        let velocity = gesture.velocity(in: self)
        
        switch gesture.state {
        case .began:
            // Handle the swipe gesture began state
            viewOffset = playerContainerView.center
        case .changed:
            // Handle the swipe gesture changed state
            let newY = viewOffset.y + translation.y
            playerContainerView.center = CGPoint(x: playerContainerView.center.x, y: newY)
        case .ended:
            // Handle the swipe gesture ended state
            if abs(progress) > 0.5 || velocity.y > 1000 || velocity.y < -1000 {
                if translation.y < 0 {
                    if isLastVideo {
                        resetSwipeToDefault()
                    } else {
                        performSwipeUpAction()
                    }
                } else {
                    if isFirstVideo {
                        resetSwipeToDefault()
                    } else {
                        performSwipeDownAction()
                    }
                }
            } else {
                resetSwipeToDefault()
            }
        default:
            break
        }
    }
    
    func performSwipeUpAction() {
        UIView.animate(withDuration: 0.3) {
            self.playerContainerView.center = CGPoint(x: self.playerContainerView.center.x, y: -self.playerContainerView.bounds.height)
        } completion: { _ in
            self.playerContainerView.center = self.viewOffset
            self.showExpandDescriptionButton()
            self.model?.onShowNextVideo()
        }
    }
    
    func performSwipeDownAction() {
        UIView.animate(withDuration: 0.3) {
            self.playerContainerView.center = CGPoint(x: self.playerContainerView.center.x, y: self.bounds.height + self.playerContainerView.bounds.height)
        } completion: { _ in
            self.playerContainerView.center = self.viewOffset
            self.showExpandDescriptionButton()
            self.model?.onShowPreviousVideo()
        }
    }
    
    func resetSwipeToDefault() {
        UIView.animate(withDuration: 0.3) {
            self.playerContainerView.center = self.viewOffset
        }
    }
}

// MARK: - Model

extension CarouselView {
    struct Model {
        let video: Video
        let isFirstVideo: Bool
        let isLastVideo: Bool
        let favouriteButtonState: Bool
        let playerVars: [String: Any]
        
        let onShowNextVideo: () -> Void
        let onShowPreviousVideo: () -> Void
        
        let onFavouriteAction: () -> Void
        let onShareAction: () -> Void
        let onOnlineCinemaAction: () -> Void
    }
}
