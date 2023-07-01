//
//  FavouriteMovieCollectionViewCell.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.06.2023.
//

import UIKit
import SnapKit

final class FavouriteMovieCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Components

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: Model) {
        titleLabel.text = model.video.movieName
    }
}

// MARK: - Private Methods

private extension FavouriteMovieCollectionViewCell {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupImageView()
        setupTitleLabel()
    }

    func setupSubviews() {
        [imageView,
         titleLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalTo(108)
            make.height.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupImageView() {
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "favouritePlaceholder_image")
    }
    
    func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
    }
}

// MARK: - Model

extension FavouriteMovieCollectionViewCell {
    struct Model {
        let video: Video
    }
}

