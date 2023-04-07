//
//  VolumeListViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit
import Foundation

class VolumeListViewController: BaseViewController {
    
    
    // MARK: Interface Builder Outlets
    @IBOutlet weak var listTypeSwitch: UISwitch!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Class variables and constants
    var isLoading = false
    
    let vm = VolumeViewModel()
        
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        listTypeSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        vm.browseType = .apiFetch
        setupUI()
        showLoader()
        vm.loadData {
            self.hideLoader()
            self.refreshCollectionView()
        }
    }

    
    //MARK: - Logics
    
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
    
    @objc func switchChanged(mySwitch: UISwitch) {
        vm.resetVolumesList()
        vm.browseType = mySwitch.isOn ? .favorites : .apiFetch
        showLoader()
        vm.loadData {
            self.hideLoader()
            self.refreshCollectionView()
        }
    }
    
    //MARK: - Reusable local constants
    struct constants {
        static let inset = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        static let cellIdentifier = "cell"
        static let columnCount = AppConstants.isDeviceAnIpad ? 4.0 : 2.0
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
        
        if indexPath.item == vm.volumes.count - 10,
           isLoading == false,
           vm.browseType == .apiFetch {
            showLoader()
            vm.loadData {
                self.hideLoader()
                self.refreshCollectionView()
            }
        }
    }
}
