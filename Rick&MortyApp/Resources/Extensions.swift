//
//  Extensions.swift
//  Rick&MortyApp
//
//  Created by Nikita on 17/1/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
