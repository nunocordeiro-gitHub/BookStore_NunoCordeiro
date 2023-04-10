//
//  ApiManager+Volumes.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import Foundation


extension ApiManager {
    /// Fetches Google Books API
    /// - Parameter startIndex: first volume index
    /// - Returns: Array of parsed volumes. Array size (maximum) defined on ``constants/volumesFetchPageSize``
    func getVolumes(startIndex: Int) async -> [Volume]? {
        
        let params = ["q": "ios",
                      "startIndex": String(describing: startIndex),
                      "maxResults": String(describing:  constants.volumesFetchPageSize)
        ]
        
        return await ApiManager.shared.sendRequest(model: [Volume].self,
                                                   with: .getVolumes,
                                                   requestType: .getRequest,
                                                   urlParameters: params
        )
    }

    // MARK: - Volumes specific constants
    struct constants {
        static let volumesFetchPageSize = 20
    }
    
}


