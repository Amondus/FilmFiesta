//
//  PlayerBottomView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 11.06.2023.
//

import UIKit
import SnapKit

final class PlayerBottomView: UIView {
    // MARK: - UI Components
    
    private let movieLabel = UILabel()
    private let rateView = RateView()
    private let countryLabel = UILabel()
    private let yearLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let expandDescriptionButton = UIButton()
    private let detailsStackView = UIStackView()
    private let genresView = GenresView()
    
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
    
    func update(with model: Model) {
        let genres = model.video.genres.map { Genre(title: $0) }

        movieLabel.text = model.video.movieName
        rateView.update(with: .init(rate: model.video.rate))
        countryLabel.text = model.video.country
        yearLabel.text = model.video.year
        descriptionLabel.text = model.video.movieDescription

        genresView.update(with: .init(genres: genres))
    }
    
    func showExpandDescriptionButton() {
        isDescriptionExpanded = false
        expandDescriptionButton.setTitle(
            "Развернуть",
            for: .normal
        )
        
        descriptionLabel.numberOfLines = 1
    }

    func hideExpandDescriptionButton() {
        isDescriptionExpanded = true
        expandDescriptionButton.setTitle(
            "Свернуть",
            for: .normal
        )
        
        descriptionLabel.numberOfLines = 10
    }
}

// MARK: - Private Methods

private extension PlayerBottomView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupDetailsStackView()
        setupLabels()
        setupExpandDescriptionButton()
    }

    func setupSubviews() {
        [movieLabel,
         detailsStackView,
         descriptionLabel,
         expandDescriptionButton,
         genresView
        ].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        movieLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        detailsStackView.snp.makeConstraints { make in
            make.top.equalTo(movieLabel.snp.bottom).offset(16)
            make.left.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsStackView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
        
        expandDescriptionButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(22)
        }
        
        genresView.snp.makeConstraints { make in
            make.top.equalTo(expandDescriptionButton.snp.bottom).offset(14)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupDetailsStackView() {
        [rateView,
         countryLabel,
         yearLabel
        ].forEach {
            detailsStackView.addArrangedSubview($0)
        }
        
        detailsStackView.spacing = 16
        detailsStackView.axis = .horizontal
    }
    
    func setupLabels() {
        setupMovieLabel()
        setupCountryLabel()
        setupYearLabel()
        setupDescriptionLabel()
    }
    
    func setupMovieLabel() {
        movieLabel.textColor = .white
        movieLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    }
    
    func setupCountryLabel() {
        countryLabel.textColor = .white
        countryLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func setupYearLabel() {
        yearLabel.textColor = .white
        yearLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func setupDescriptionLabel() {
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    func setupExpandDescriptionButton() {
        showExpandDescriptionButton()
        expandDescriptionButton.contentHorizontalAlignment = .left
        
        expandDescriptionButton.setTitleColor(
            .init(named: "brandPink_color"),
            for: .normal
        )
        
        expandDescriptionButton.addTarget(
            self,
            action: #selector(descriptionButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    func descriptionButtonTapped() {
        if isDescriptionExpanded {
            showExpandDescriptionButton()
        } else {
            hideExpandDescriptionButton()
        }
    }
}

// MARK: - Model

extension PlayerBottomView {
    struct Model {
        let video: Video
    }
}

