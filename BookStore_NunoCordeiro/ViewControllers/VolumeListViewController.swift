//
//  VolumeListViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit
import Foundation

class VolumeListViewController: BaseViewController {
    
    
    //  MARK: Interface Builder Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //  MARK: Class variables and constants
    var collectionViewFirstLoad = false
    
    //represents the viewModel for the current VC. returs the VM that was injected durint instantiation
    var vm: VolumeViewModel {
        return viewModel as! VolumeViewModel
    }
    
    //  MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewFirstLoad = true
        
        setupUI()
        showLoader()
        vm.loadData {
            self.hideLoader()
            self.refreshCollectionView()
            self.collectionViewFirstLoad = false
        }
    }

    
    //  MARK: - Logics
    
    fileprivate func setupUI() {
        let cellNib = UINib(nibName: String(describing: VolumeCollectionViewCell.self), bundle: .main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: constants.cellIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = constants.inset.left * 2.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = .secondary
    }
    
    func refreshCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Reusable local constants
    struct constants {
        static let inset = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        static let cellIdentifier = "cell"
        static let columnCount = AppConstants.isDeviceAnIpad ? 4.0 : 2.0
        static let reloadBuffer = 10    //number of elements before being presented to start downloading more
    }
}

//MARK: - Collectionview Delegation Stubs
extension VolumeListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.volumes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: constants.cellIdentifier, for: indexPath as IndexPath) as! VolumeCollectionViewCell
        if let currentVolumeInfo = vm.volumes[indexPath.item].volumeInfo {
            cell.configure(volumeInfo: currentVolumeInfo)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VolumeDetailViewController.instantiate()
        vc.volume = vm.volumes[indexPath.item]
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return constants.inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / constants.columnCount - layout.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height: widthPerItem * AppConstants.shared.goldenRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item == vm.volumes.count - constants.reloadBuffer,
           !collectionViewFirstLoad,
           vm.browseType == .apiFetch {
            vm.loadData {
                self.refreshCollectionView()
            }
        }
    }
}

extension VolumeListViewController: VolumeDetailDelegate {
    func didChangeFavorite() {
        vm.loadData {
            self.refreshCollectionView()
        }
    }
}
