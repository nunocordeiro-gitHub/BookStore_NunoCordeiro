//
//  VolumeDetailViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit

class VolumeDetailViewController: BaseViewController {
    
    
    // MARK: - Interface Builder Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var thumbailImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var buyButton: PrimaryButton!
    
    
    // MARK: - ViewController wide constants and variables
    var volume: Volume?
    var buyUrl: String?
    
    //TODO: emptyState?
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindModelData()
        setupUI()
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        favoriteButton.frame = CGRect(x: thumbailImageView.frame.maxX - constants.favoriteButtonSize / 2,
                                      y: thumbailImageView.frame.minY - constants.favoriteButtonSize / 2,
                                      width: constants.favoriteButtonSize,
                                      height: constants.favoriteButtonSize)
    }
    // MARK: - UI
    fileprivate func setupUI() {

        titleLabel.textColor = UIColor.primary
        descriptionTextView.isEditable = false
        thumbailImageView.addDropShadow()

    
        
        
        
        setupFavoriteButton()
        
        textViewBottomConstraint.isActive = volume?.saleInfo?.buyLink == nil
        if let buyLink = volume?.saleInfo?.buyLink {
            buyUrl = buyLink
            
            var buyTitle = constants.buyTitle
            
            if let finalPrice = volume?.saleInfo?.listPrice?.amount ?? volume?.saleInfo?.retailPrice?.amount,
               let currencyCode = volume?.saleInfo?.retailPrice?.currencyCode {
                buyTitle = "\(buyTitle) \(finalPrice) \(currencyCode)"
            }
            
            buyButton.setTitle(buyTitle , for: .normal)
        } else {
            buyButton.removeFromSuperview()
            textViewBottomConstraint.constant = 20
        }
    }
    
    fileprivate func setupFavoriteButton() {
        
        let sfSymbolName: String
        let heartButtonConfig = UIImage.SymbolConfiguration(pointSize: constants.favoriteButtonSize, weight: .light, scale: .large)
        
        if AppConstants.shared.favoriteVolumes.contains(where: {$0.id == volume?.id}) {
            favoriteButton.tintColor = .red
            sfSymbolName = "heart.fill"
        } else {
            favoriteButton.tintColor = .lightGray
            sfSymbolName = "heart.circle"
        }
        
        let heartImage = UIImage(systemName: sfSymbolName, withConfiguration: heartButtonConfig)
        favoriteButton.setImage(heartImage, for: .normal)
    }
    
    fileprivate func bindModelData() {
        
        titleLabel.text = volume?.volumeInfo?.title
        authorLabel.text = volume?.volumeInfo?.authors?.first
        descriptionTextView.text = volume?.volumeInfo?.description
        
        if let imgURL = volume?.volumeInfo?.imageLinks?.thumbnail {
            thumbailImageView.load(urlString: imgURL)
        }
    }
    
    
    // MARK: - User Interaction
    
    @IBAction func buyButtonTapped(_ sender: Any) {
        if  let volumeUrl = self.buyUrl,
            let url = URL(string: volumeUrl) {
            UIApplication.shared.open(url)
        } else {
            showError(message: constants.noLinkMessage)
        }
    }
    
    @IBAction func favoriteTapped(_ sender: Any) {
        guard let volume = self.volume else { return }
        
        if AppConstants.shared.favoriteVolumes.contains(where: {$0.id == volume.id}) {
            AppConstants.shared.favoriteVolumes.removeAll(where: {$0.id == volume.id})
        } else {
            AppConstants.shared.favoriteVolumes.append(volume)
        }
        
        setupFavoriteButton()

        UserDefaults.standard.userVolumes = AppConstants.shared.favoriteVolumes
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    // MARK: - ViewController constants
    struct constants {
        static let buyTitle = "Comprar por" //localization
        static let noLinkMessage = "Não há link disponível"
        static let favoriteButtonSize:CGFloat = 50
    }
}
