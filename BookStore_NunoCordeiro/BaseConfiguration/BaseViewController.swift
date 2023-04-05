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
