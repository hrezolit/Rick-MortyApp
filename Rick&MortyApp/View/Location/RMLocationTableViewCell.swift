//
//  RMLocationTableViewCell.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import UIKit

final class RMLocationTableViewCell: UITableViewCell {

   static let cellIdentifire = "RMLocationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        
    }
    
}
