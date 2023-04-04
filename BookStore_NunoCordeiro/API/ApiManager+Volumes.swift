//
//  ApiManager+Volumes.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import Foundation


extension ApiManager {
    func getVolumes() async -> [Volume]? {
        return await ApiManager.shared.sendRequest(model: [Volume].self, with: .getVolumes, requestType: .getRequest)
    }
}


