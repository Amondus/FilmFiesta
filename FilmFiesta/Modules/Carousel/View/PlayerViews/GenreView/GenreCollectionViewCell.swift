//
//  GenreCollectionViewCell.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.06.2023.
//

import UIKit
import SnapKit

final class GenreCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Components

    let titleLabel = UILabel()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame
        return layoutAttributes
   }
    
    func update(with model: Model) {
        titleLabel.text = model.genre.title

        contentView.backgroundColor = model.genre.isSelected ?
        UIColor(named: "brandPink_color") :
        UIColor(named: "genreBackground_color")
    }
}

// MARK: - Private Methods

private extension GenreCollectionViewCell {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupUI()
        setupTitleLabel()
    }

    func setupSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(6)
            make.right.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    func setupUI() {
        contentView.layer.cornerRadius = 4
        contentView.backgroundColor = UIColor(named: "genreBackground_color")
    }
    
    func setupTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
}

// MARK: - Model

extension GenreCollectionViewCell {
    struct Model {
        let genre: Genre
    }
}
