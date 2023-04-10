//
//  AppConstants.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import Foundation
import UIKit

/// Singleton with constants and variables to be used throughout the app
class AppConstants {
    
    private init() {}   // ensures singleton
    
    static let shared = AppConstants()
    
    let AppName = "Bookstore"
    let goldenRatio = 1.61803398875
    
    var favoriteVolumes: [Volume] = UserDefaults.standard.userVolumes
    
    static var isDeviceAnIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    let mainStoryboardName = "Main"
    
}
    
