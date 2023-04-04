//
//  VolumeListViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit

class VolumeListViewController: BaseViewController {

    
    var volumes: [Volume]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            showLoader()
            volumes = await ApiManager.shared.getVolumes()
            hideLoader()
            
        }
    }
    

    @IBAction func listTap(_ sender: Any) {
        
        Task {
            let vc = VolumeDetailViewController.instantiate()
            present(vc, animated: true)
        }
    }
}
