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
        
        var configuration = UIButton.Configuration.filled()
        
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom:8, trailing: 20)
        configuration.baseBackgroundColor = .primary
        
        configuration.cornerStyle = .capsule
        self.configuration = configuration
        layer.cornerCurve = .continuous
        layer.cornerRadius = self.bounds.height / 2
        
    }
    
}

