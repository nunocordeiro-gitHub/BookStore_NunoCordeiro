//
//  PrimaryButton.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 07/04/2023.
//

import UIKit

class PrimaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .primary
        setTitleColor(.secondary, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        layer.cornerRadius = bounds.height / 2.0 - contentEdgeInsets.top / 2.0
        
    }
}

