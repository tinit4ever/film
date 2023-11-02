//
//  FilmTableViewCell.swift
//  Film
//
//  Created by cuongnh5 on 27/10/2023.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    static let identifier: String = "FilmTableViewCell"
    
    var movies: [Movie] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    func configure(viewModel: ViewModelProtocol) {
        self.collectionView.reloadData()
        self.movies = viewModel.movies
    }
    
}

extension FilmTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifier, for: indexPath) as? FilmCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.confiure(with: movies[indexPath.row])
        
        return cell
    }
    
    
}

extension FilmTableViewCell: UICollectionViewDelegate {
    
}
