//
//  AppConstants.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import Foundation
import UIKit

class AppConstants {
    
    private init() {}
    static let shared = AppConstants()
    
    let AppName = "Bookstore"
    
    public struct Colors {
        static let secondaryColor: UIColor = UIColor(named: "secondaryColor")!
    }
    
    public struct Fonts {
        static let largeTitleFont: UIFont = UIFont(name: "Georgia", size: 40)!
        static let secondaryFont = UIFont(name: "Trebuchet MS", size: 18)
    }
    
    enum userProfile {
        case hcp, admin, abm
    }
 
    var mainStoryboardName: String {
        return UIDevice.current.userInterfaceIdiom == .pad ? "Main_iPad" : "Main"
    }
}






