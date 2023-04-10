//
//  BaseViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit

/// UIViewController subclass with additional functions to be reused on any App VC
class BaseViewController: UIViewController {
    
    private var loaderView: UIView = UIView()
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var viewModel: BaseViewModel! = nil
    
    
    //MARK: General UI Features
    
    func showLoader() {
        
        loaderView = UIView(frame: view.frame)
        loaderView.backgroundColor = .black
        loaderView.alpha = 0.5
        spinner.transform = CGAffineTransform(scaleX: 2, y: 2)
        spinner.color = .primary

        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.view.addSubview(self.loaderView)
            self.spinner.center = self.view.center
            self.view.insertSubview(self.spinner, aboveSubview: self.loaderView)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.loaderView.removeFromSuperview()
            self.spinner.removeFromSuperview()
        }
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
    

    // MARK: Create instance
    static func instantiate() -> Self {
        
        let vc = UIStoryboard.init(name: AppConstants.shared.mainStoryboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self.classForCoder())) as! Self
        return vc
    }
    
    static func instatiate(viewModel: BaseViewModel) -> Self    {
        let vc  = self.instantiate()
        vc.viewModel = viewModel
        return vc
    }
}
