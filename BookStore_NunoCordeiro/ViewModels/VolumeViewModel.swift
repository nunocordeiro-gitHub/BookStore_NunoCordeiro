//
//  VolumesViewModel.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 07/04/2023.
//

import Foundation

class VolumeViewModel: BaseViewModel {
    
    
    var startIndex = 0
    var volumes: [Volume] = []
    var browseType: browseType
    
    /// Types of datasource to fetch volumes
    /// apiFetch -> fetches againsta Google Books API
    /// favorites -> fetcges against UserDefaults local storage
    ///
    /// Additional datasources can be added such as local storage on Realm, or event CloudKit to allow multi device sync of favorites
    enum browseType {
        case apiFetch
        case favorites
    }
    
    //  MARK: Custom initializer
    init(browseType: browseType) {
        self.browseType = browseType
    }
    
    
    //  MARK: - Data handling
    
    func resetVolumesList() {
        volumes.removeAll()
    }
    
    /// Fetches Volumes from the setted dataSource (i.e., API or Favorites) and loads them to volumes variable
    /// - Parameter completion: escaping closure
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

