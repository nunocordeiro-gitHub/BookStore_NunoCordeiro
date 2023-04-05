//
//  AppConstants.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import Foundation
import UIKit

class AppConstants {
    
    private init() {}   // ensures singleton
    
    static let shared = AppConstants()
    
    let AppName = "Bookstore"
    
    static var isDeviceAnIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public struct Colors {
        static let secondaryColor: UIColor = UIColor(named: "secondaryColor") ?? UIColor.systemBackground
    }
    
    public struct Fonts {
        static let largeTitleFont: UIFont = UIFont(name: "Georgia", size: 40)!
        static let secondaryFont = UIFont(name: "Trebuchet MS", size: 18)
    }
 
    var mainStoryboardName: String {
        return AppConstants.isDeviceAnIpad ? "Main_iPad" : "Main"
    }
}
