//
//  CustomPlayerView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 21.06.2023.
//

import UIKit
import SnapKit
import YouTubeiOSPlayerHelper

final class CustomPlayerView: UIView {
    // MARK: - UI Components
    
    private let playerView = YTPlayerView()

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
    
    func update(with model: CustomPlayerView.Model) {
        self.model = model
        showLoadingState()
        loadVideo()
    }
    
    func resumeVideo() {
        playerView.playVideo()
    }
    
    func pauseVideo() {
        playerView.pauseVideo()
    }
}

// MARK: - YTPlayerViewDelegate

extension CustomPlayerView: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing, .cued, .ended, .paused:
            hideLoadingState()
        case .buffering:
            showLoadingState()
        case .unknown, .unstarted:
            showLoadingState()
            loadVideo()
        @unknown default:
            assertionFailure("Unknown YTPlayerState")
        }
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        loadVideo()
    }
}

// MARK: - Private Methods

private extension CustomPlayerView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupPlayerView()
    }

    func setupSubviews() {
        addSubview(playerView)
    }
    
    func setupConstraints() {
        playerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-120)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(120)
        }
    }

    func setupPlayerView() {
        playerView.delegate = self
        playerView.isUserInteractionEnabled = false
    }
    
    func showLoadingState() {
        playerView.isHidden = true
        backgroundColor = UIColor(named: "loadingPlayer_color")
    }
    
    func hideLoadingState() {
        playerView.isHidden = false
        backgroundColor = .black
    }
    
    func loadVideo() {
        guard let model = model else { return }
        
        playerView.load(
            withVideoId: model.video.videoId,
            playerVars: model.playerVars
        )
    }
}

// MARK: - Model

extension CustomPlayerView {
    struct Model {
        let video: Video
        let playerVars: [String: Any]
    }
}


