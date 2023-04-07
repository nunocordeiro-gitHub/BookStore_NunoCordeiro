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
    
    var favoriteVolumes: [Volume] = UserDefaults.standard.userVolumes
    
    static var isDeviceAnIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var mainStoryboardName: String {
        return AppConstants.isDeviceAnIpad ? "Main_iPad" : "Main"
    }
}
    