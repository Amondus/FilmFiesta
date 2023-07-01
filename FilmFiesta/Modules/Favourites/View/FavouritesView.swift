//
//  FavouritesView.swift
//  FilmFiesta
//
//  Created by Антон Захарченко on 12.06.2023.
//

import UIKit
import SnapKit

final class FavouritesView: UIView {
    // MARK: - UI Components
    
    private let layout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout
    )
    
    private let emptyFavouritesLabel = UILabel()
    
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
    
    // MARK: - Internal Methods
    
    func update(with model: FavouritesView.Model) {
        self.model = model
        collectionView.reloadData()
        emptyFavouritesLabel.isHidden = model.videos.count != 0
    }
}

// MARK: - UICollectionViewDataSource

extension FavouritesView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        model?.videos.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let video = model?.videos[indexPath.item],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteMovieCollectionViewCell", for: indexPath) as? FavouriteMovieCollectionViewCell
        else { return UICollectionViewCell () }
        
        cell.update(with: .init(video: video))
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavouritesView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: 202)
    }
}

// MARK: - Private Methods

private extension FavouritesView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        setupUI()
        setupEmptyFavouritesLabel()
        setupCollectionView()
    }
    
    func setupSubviews() {
        [emptyFavouritesLabel,
         collectionView
        ].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        emptyFavouritesLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func setupUI() {
        backgroundColor = UIColor(named: "loadingPlayer_color")
    }
    
    func setupEmptyFavouritesLabel() {
        emptyFavouritesLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        emptyFavouritesLabel.numberOfLines = 0
        emptyFavouritesLabel.textAlignment = .center
        emptyFavouritesLabel.text = "Нет избранных видео"
    }
    
    func setupCollectionView() {
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear

        collectionView.register(
            FavouriteMovieCollectionViewCell.self,
            forCellWithReuseIdentifier: "FavouriteMovieCollectionViewCell"
        )
    }
}

// MARK: - Model

extension FavouritesView {
    struct Model {
        let videos: [Video]
    }
}
