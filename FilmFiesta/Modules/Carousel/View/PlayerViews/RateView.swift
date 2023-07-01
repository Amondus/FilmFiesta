//
//  RateView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.06.2023.
//

import UIKit
import SnapKit

final class RateView: UIView {
    // MARK: - UI Components

    private let rateLabel = UILabel()
    
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
        rateLabel.text = model.rate
    }
}

// MARK: - Private Methods

private extension RateView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupUI()
        setupRateLabel()
    }

    func setupSubviews() {
        addSubview(rateLabel)
    }
    
    func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(26)
        }

        rateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    
    func setupUI() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        backgroundColor = UIColor(named: "rate_color")
    }
    
    func setupRateLabel() {
        rateLabel.textColor = .white
        rateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
}

// MARK: - Model

extension RateView {
    struct Model {
        let rate: String
    }
}

