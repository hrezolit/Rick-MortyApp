//
//  RMSearchInputView.swift
//  Rick&MortyApp
//
//  Created by Nikita on 8/2/23.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

/// Main view for searching
final class RMSearchInputView: UIView {
    
    weak var delegate: RMSearchInputViewDelegate?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search..."
        
        return searchBar
    }()
    
    private var viewModel: RMSearchInputViewViewModel? {
        didSet {
            guard let viewModel, viewModel.hasDynamicOption else { return }
            let options = viewModel.options
            createOptionsSelectionsViews(options: options)
        }
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(searchBar)
        addConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public:
    
    public func configure(with viewModel: RMSearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }
    
    public func presentKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Private:
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
//        stackView.backgroundColor = .systemBackground
        
        return stackView
    }
    
    private func createOptionsSelectionsViews(options: [RMSearchInputViewViewModel.DynamicOption]) {
        
        let stackView = createOptionStackView()
        
        for x in 0..<options.count {
            
            let option = options[x]
            
            let button = createButton(with: option, tag: x)

            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(with option: RMSearchInputViewViewModel.DynamicOption, tag: Int) -> UIButton {
        
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(
                string: option.rawValue,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                    .foregroundColor: UIColor.label
                ]),
            for: .normal)
        
        button.backgroundColor = .secondarySystemBackground
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.tag = tag
        button.layer.cornerRadius = 5
        
        return button
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else { return }
        let tag = sender.tag
        let selected = options[tag]
        delegate?.rmSearchInputView(self, didSelectOption: selected)
    }
    
    private  func addConstraints() {
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
