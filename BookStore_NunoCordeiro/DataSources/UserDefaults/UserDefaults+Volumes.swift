//
//  UserDefaults+Volumes.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 07/04/2023.
//

import Foundation

extension UserDefaults {
    var userVolumes: [Volume] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "userVolumes") else { return [] }
            return (try? PropertyListDecoder().decode([Volume].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "userVolumes")
        }
    }
}
