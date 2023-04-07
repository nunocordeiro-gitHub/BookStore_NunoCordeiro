//
//  BaseViewController.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var loaderView: UIView = UIView()
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = .white // UIColor(named: "background")
        // Do any additional setup after loading the view.
    }
    //MARK: General UI Features
    
    func showLoader() {
        
        loaderView = UIView(frame: view.frame)
        loaderView.backgroundColor = .black
        loaderView.alpha = 0.5
        spinner.transform = CGAffineTransform(scaleX: 2, y: 2)

        
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
}
