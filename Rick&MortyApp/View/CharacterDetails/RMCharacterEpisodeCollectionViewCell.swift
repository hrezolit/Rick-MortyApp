//
//  RMCharacterEpisodeCollectionViewCell.swift
//  Rick&MortyApp
//
//  Created by Nikita on 24/1/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubviews(seasonLabel, nameLabel, airDateLabel)
        
        setUpLayer()
        
        addConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    // MARK: - Private:
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            
            self?.seasonLabel.text = "Episode: " + data.episode
            self?.nameLabel.text = data.name
            self?.airDateLabel.text = "Aired on: " + data.air_date
        }
        
        viewModel.fetchEpisode()
        contentView.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.8206997514, alpha: 1).cgColor
    }
    
    // MARK: - Private:
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 4
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            seasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            seasonLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            airDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }
}
