//
//  RMEpisodeInfoCollectionViewCell.swift
//  Rick&MortyApp
//
//  Created by Nikita on 30/1/23.
//

import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private let valueLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(titleLable, valueLable)
        addConstraints()
        setUpLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLable.text = nil
        valueLable.text = nil
    }
    
    func configure(with viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
        titleLable.text = viewModel.title
        valueLable.text = viewModel.value
    }
    
    //MARK: - Private:
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            titleLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            titleLable.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
            
            valueLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            valueLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            valueLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            valueLable.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47)
            
        ])
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
}

