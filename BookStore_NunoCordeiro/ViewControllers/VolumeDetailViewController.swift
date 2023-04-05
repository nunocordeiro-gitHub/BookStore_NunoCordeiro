//
//  VolumeDetailViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit

class VolumeDetailViewController: BaseViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    var volume: Volume?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    private func configure() {
        titleLabel.text = volume?.volumeInfo.title
        authorLabel.text = volume?.volumeInfo.authors?.first
    }

    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
