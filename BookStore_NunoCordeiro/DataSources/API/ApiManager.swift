//
//  APIManager.swift
//  BookStore_NunoCordeiro
//
//  Created by Nuno Cordeiro on 04/04/2023.
//

import Foundation

/// Singleton to fetch Google Books API
class ApiManager {
    
    
    //MARK: Constants and shared values
    private let baseURL = "https://www.googleapis.com/"
    
    enum Endpoint: String {
        case getVolumes = "books/v1/volumes"
    }
    
    enum RequestType: String {
        case postRequest = "POST"
        case getRequest = "GET"
    }
    
    //MARK: Singleton
    static var shared = ApiManager()
    private init () {}
    
    
    //MARK: - Implementation
    
    /// Generic funtion to fetch a given endpoint and return decoded object
    /// - Parameters:
    ///   - model: Exoected data struct to be returned
    ///   - endpoint: address to fetch as enumerated in ``Endpoint``
    ///   - requestType: REST verb as enumerated in ``RequestType``
    ///   - urlParameters: Dictionary of parameters to be included in URL
    /// - Returns: Object ir array of type T described in model parameter
    func sendRequest<T:Codable>(model: T.Type,
                                with endpoint: Endpoint,
                                requestType: RequestType,
                                urlParameters: [String:String] = [:]) async -> T? {
        
        var urlString = baseURL + endpoint.rawValue
        
        //  build queryString based on urlParameters
        var first = true
        for (key, value) in urlParameters {
            first ? urlString.append("?") : urlString.append("&")
            first = false            
            urlString.append("\(key)=\(value)")
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            let res = try JSONDecoder().decode(T.self, from:data, keyPath: "items")
            return res
        } catch {
            DLog(url.absoluteString)
            DLog(error)                         //  Sometimes gives additional clues on what went wrong
            DLog(error.localizedDescription)    //  More readable description on what went wrong
                                                //  TODO: push error info to external log feature such as firebase / crashlytics or similar
            return nil
        }
    }
}
