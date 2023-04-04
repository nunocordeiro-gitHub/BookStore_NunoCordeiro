//
//  BaseViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var loaderView: UIView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white // UIColor(named: "background")
        // Do any additional setup after loading the view.
    }
    //MARK: General UI Features
    
    func showLoader() {
        
        loaderView = UIView(frame: view.frame)
        loaderView.backgroundColor = .black
        loaderView.alpha = 0.5

        self.view.addSubview(loaderView)
    }
    
    func hideLoader() {
        loaderView.removeFromSuperview()
    }

    func configNavBar() {

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: AppConstants.Colors.secondaryColor]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: AppConstants.Colors.secondaryColor,
                                                                             .font: AppConstants.Fonts.largeTitleFont]
        navigationController?.navigationBar.tintColor = .black
        self.addLogoToNavigationBarItem()
        
    }
    
    // MARK: Alert Controllers
    func showError(message: String) {
    
        let uac = UIAlertController(title: AppConstants.shared.AppName,
                                    message: message,
                                    preferredStyle: .alert)
        
        uac.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(uac, animated: true)
    }
    
    func showMessage(message: String) {
    
        let uac = UIAlertController(title: AppConstants.shared.AppName,
                                    message: message,
                                    preferredStyle: .alert)
        
        uac.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(uac, animated: true)
    }
    
    
    func addLogoToNavigationBarItem() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "minerva_new")
        //imageView.backgroundColor = .lightGray

        // In order to center the title view image no matter what buttons there are, do not set the
        // image view as title view, because it doesn't work. If there is only one button, the image
        // will not be aligned. Instead, a content view is set as title view, then the image view is
        // added as child of the content view. Finally, using constraints the image view is aligned
        // inside its parent.
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        
        
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    // MARK: Create instance
    static func instantiate() -> Self {
        
        let vc = UIStoryboard.init(name: AppConstants.shared.mainStoryboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self.classForCoder())) as! Self
        return vc
    }
}
