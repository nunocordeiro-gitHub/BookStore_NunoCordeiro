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
    @IBOutlet weak var thumbailImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buyButton: PrimaryButton!
    
    var volume: Volume?
    var buyUrl: String?
    
    //TODO: emptyState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindModelData()
    }
    
    fileprivate func setupUI() {
        //closeButton.tintColor = .primary
        titleLabel.textColor = UIColor.primary
        descriptionTextView.isEditable = false
        thumbailImageView.addDropShadow()
        
        textViewBottomConstraint.isActive = volume?.saleInfo?.buyLink == nil
        if let buyLink = volume?.saleInfo?.buyLink {
            
            var buyTitle = constants.buyTitle
            
            if let finalPrice = volume?.saleInfo?.listPrice?.amount ?? volume?.saleInfo?.retailPrice?.amount,
               let currencyCode = volume?.saleInfo?.retailPrice?.currencyCode {
                buyTitle = "\(buyTitle) \(finalPrice) \(currencyCode)"
            }
            
            buyButton.setTitle(buyTitle , for: .normal)
            buyUrl = buyLink
        } else {
            buyButton.isHidden = true
            textViewBottomConstraint.constant = 20
        }
    }
    
    fileprivate func bindModelData() {
        
        titleLabel.text = volume?.volumeInfo?.title
        authorLabel.text = volume?.volumeInfo?.authors?.first
        descriptionTextView.text = volume?.volumeInfo?.description
        
        if let imgURL = volume?.volumeInfo?.imageLinks?.thumbnail {
            thumbailImageView.load(urlString: imgURL)
        }
    }

    @IBAction func buyButtonTapped(_ sender: Any) {
        if  let volumeUrl = self.buyUrl,
            let url = URL(string: volumeUrl) {
            UIApplication.shared.open(url)
        } else {
            showError(message: constants.noLinkMessage)
        }
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    struct constants {
        static let buyTitle = "Comprar por " //localization
        static let noLinkMessage = "Não há link disponível"
    }

}
