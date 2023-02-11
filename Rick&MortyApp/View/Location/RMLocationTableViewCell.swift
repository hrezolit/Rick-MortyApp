//
//  RMLocationTableViewCell.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import UIKit

/// Location table view cell
final class RMLocationTableViewCell: UITableViewCell {
    
    static let cellIdentifire = "RMLocationTableViewCell"
    
    private let nameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = #colorLiteral(red: 0, green: 1, blue: 0.8206997514, alpha: 1)
        
        return label
    }()
    
    private let typeLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = #colorLiteral(red: 0, green: 0.6386629343, blue: 0.5290715098, alpha: 1)
        
        return label
    }()
    
    private let dimensionLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = #colorLiteral(red: 0, green: 0.4969029427, blue: 0.4115843475, alpha: 1)
        
        return label
    }()
    
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(nameLable, typeLable, dimensionLable)
        
        addConstraints()
        accessoryType = .disclosureIndicator
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLable.text = nil
        typeLable.text = nil
        dimensionLable.text = nil
    }
    
    //MARK: - Public:
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        nameLable.text = viewModel.name
        typeLable.text = viewModel.type
        dimensionLable.text = viewModel.dimension
    }
    
    //MARK: - Private:
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            nameLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            typeLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 10),
            typeLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            typeLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            dimensionLable.topAnchor.constraint(equalTo: typeLable.bottomAnchor, constant: 10),
            dimensionLable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            dimensionLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            dimensionLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
