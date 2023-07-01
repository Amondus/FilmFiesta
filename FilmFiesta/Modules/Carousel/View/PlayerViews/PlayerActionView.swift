//
//  PlayerActionView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 11.06.2023.
//

import UIKit
import SnapKit

final class PlayerActionView: UIView {
    // MARK: - UI Components

    private let imageView = UIImageView()
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // MARK: - Parameters
    
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
    
    func update(with model: Model) {
        self.model = model
        imageView.image = model.image
    }
}

// MARK: - Private Methods

private extension PlayerActionView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupUI()
        setupActionView()
    }

    func setupSubviews() {
        [blurView,
         imageView
        ].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }

        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(12)
            make.right.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func setupUI() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        blurView.alpha = 0.6
    }
    
    func setupActionView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionViewTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    func actionViewTapped() {
        model?.tapAction()
    }
}

// MARK: - Model

extension PlayerActionView {
    struct Model {
        let image: UIImage
        let tapAction: () -> Void
    }
}
