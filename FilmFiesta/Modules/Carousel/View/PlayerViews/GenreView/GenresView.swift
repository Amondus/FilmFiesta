//
//  GenresView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.06.2023.
//

import UIKit
import SnapKit

final class GenresView: UIView {
    // MARK: - UI Components

    private let layout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout
    )
    
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
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension GenresView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        model?.genres.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let genre = model?.genres[indexPath.item],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as? GenreCollectionViewCell
        else { return UICollectionViewCell () }
        
        cell.update(with: .init(genre: genre))
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GenresView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let genre = model?.genres[indexPath.item],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as? GenreCollectionViewCell
        else { return .zero }

        cell.titleLabel.text = genre.title
        cell.titleLabel.sizeToFit()
        return CGSize(width: cell.titleLabel.frame.width + 12, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        model?.genres[indexPath.item].isSelected.toggle()
        collectionView.reloadData()
    }
}

// MARK: - Private Methods

private extension GenresView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupCollectionView()
    }

    func setupSubviews() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    func setupCollectionView() {
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(
            GenreCollectionViewCell.self,
            forCellWithReuseIdentifier: "GenreCollectionViewCell"
        )
    }
}

// MARK: - Model

extension GenresView {
    struct Model {
        var genres: [Genre]
    }
}
