//
//  VolumeDetailViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit

class VolumeDetailViewController: BaseViewController {

    var volume: Volume?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        
    }

    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
