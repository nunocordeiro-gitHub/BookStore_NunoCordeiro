//
//  APIManager.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import Foundation

class ApiManager {
    
    
    //MARK: Constants and shared values
    private let baseURL = "https://www.googleapis.com/books/v1/"
    
    enum Endpoint: String {
        case getVolumes = "volumes?q=ios&maxResults=20&startIndex=0"
        case getVolumeDetails = ""
    }
    
    enum RequestType: String {
        case postRequest = "POST"
        case getRequest = "GET"
    }
    
    //MARK: Singleton
    static var shared = ApiManager()
    private init () {}
    
    
    //MARK: - Implementation
    
    func sendRequest<T:Codable>(model: T.Type,
                                with endpoint: Endpoint,
                                requestType: RequestType,
                                parameters: [String:Any] = [:],
                                maxResults: Int? = 20,
                                startIndex: Int? = 0) async -> T? {
        
        let urlString = baseURL + endpoint.rawValue
        guard let url = URL(string: urlString) else { return nil }
        DLog(url.absoluteString)
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            let res = try JSONDecoder().decode(T.self, from:data, keyPath: "items")
            DLog(res.jsonString)
            return res
        } catch {
            DLog(error)                         //  Sometimes gives additional clues on what went wrong
            DLog(error.localizedDescription)    //  More readable description on what went wrong
                                                //  TODO: push error info to external log feature such as firebase / crashlytics or similar
            return nil
        }
    }
}
