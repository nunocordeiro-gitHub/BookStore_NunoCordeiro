//
//  VolumesViewModel.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 07/04/2023.
//

import Foundation

class VolumeViewModel {
    
    var startIndex = 0
    var volumes: [Volume] = []
    
    var browseType: browseType = .apiFetch
    enum browseType {
        case apiFetch, favorites
    }
    
    func resetVolumesList() {
        volumes.removeAll()
    }
    
    func loadData(completion: @escaping() -> Void) {
        
        if self.browseType != .apiFetch {
            volumes = AppConstants.shared.favoriteVolumes
            startIndex = 0
            completion()
            return
        }
        
        Task {
            if let newPageVolumes = await ApiManager.shared.getVolumes(startIndex: startIndex) {
                volumes.append(contentsOf: newPageVolumes)
                startIndex += ApiManager.constants.volumesFetchPageSize
                completion()
                
            }
        }
    }
}

