//
//  VolumeListViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit

class VolumeListViewController: BaseViewController {

    
    // MARK: Interface Builder Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Class variables and constants
    let reuseIdentifier = "cell"
    var volumes: [Volume]?
    
    
    //MARK: ViewControllerlifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    //MARK: - Logics
    
    func configure() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        let cellNib = UINib(nibName: String(describing: VolumeCollectionViewCell.self), bundle: .main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        Task {
            showLoader()
            volumes = await ApiManager.shared.getVolumes()
            collectionView.reloadData()
            hideLoader()
        }
    }
}



extension VolumeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return volumes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! VolumeCollectionViewCell
        if let currentVolumeInfo = volumes?[indexPath.item].volumeInfo {
            cell.configure(volumeInfo: currentVolumeInfo)
        }        
        return cell
    }
    
    
}
