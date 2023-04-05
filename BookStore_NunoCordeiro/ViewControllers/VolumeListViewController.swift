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
    var isLoading = false
    
    //MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        configure()
    }
    
    
    //MARK: - Logics
    
    func configure() {
        
        let cellNib = UINib(nibName: String(describing: VolumeCollectionViewCell.self), bundle: .main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = constants.inset.left * 2.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = AppConstants.Colors.secondaryColor
        
        Task {
            showLoader()
            volumes = await ApiManager.shared.getVolumes(startIndex: 0)
            collectionView.reloadData()
            hideLoader()
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) { // Remove the 1-second delay if you want to load the data without waiting
                // Download more data here
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
    //MARK: - Reusable local constants
    struct constants {
        static let inset = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    }
}


extension VolumeListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VolumeDetailViewController.instantiate()
        vc.volume = volumes?[indexPath.item]
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return constants.inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let colCount = AppConstants.isDeviceAnIpad ? 4.0 : 2.0
        let widthPerItem = collectionView.frame.width / colCount - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height: widthPerItem * 1.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let datasourceCount = volumes?.count else { return }
        
        if indexPath.item == datasourceCount - 10, !isLoading {
            loadMoreData()
        }
    }
}
