//
//  NetworkProvider.swift
//  MoviesApp
//
//  Created by Nitin Sakhare on 14/02/23.
//

import UIKit
import Foundation
import AVFoundation

struct NetworkProviderConstants {
    static let apiKey = "04c0083bce7f35bf9761bafc54d329b5"
    static let baseURL = "https://api.themoviedb.org/"
    static let imgBaseURL = "https://image.tmdb.org/t/p/w500/"
    
    static let movieListURL = baseURL + "4/list/1" + "?api_key=\(apiKey)"
    static let movieDetailURL = baseURL + "3/movie/"
}

protocol APIServiceProtocol {
    func startNetworkTask(urlStr:String, params:[String:Any], resultHandler: @escaping (Result<Data?, Error>) -> Void)
}

class NetworkProvider: APIServiceProtocol {
    static let shared = NetworkProvider()
    
    func startNetworkTask(urlStr:String, params:[String:Any], resultHandler: @escaping (Result<Data?, Error>) -> Void)  {
        
        guard let urlObject = URL(string:urlStr) else {
            let errorTemp = CustomError(title: "url error", description: "", code: 500)
            resultHandler(.failure(errorTemp))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: urlObject)) { dataObject, responseObj, errorObject in
            if let error = errorObject {
                resultHandler(.failure(error))
            } else {
                resultHandler(.success(dataObject))
            }
        }.resume()
    }
}

protocol MovieErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

struct CustomError: MovieErrorProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
    
}
