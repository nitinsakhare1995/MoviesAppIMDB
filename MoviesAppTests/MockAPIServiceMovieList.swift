//
//  MockAPIServiceMovieList.swift
//  MoviesAppTests
//
//  Created by Nitin Sakhare on 14/02/23.
//

import Foundation
@testable import MoviesApp

class MockAPIServiceMovieList:  APIServiceProtocol {
    
    let moviesListModel: MovieObserver<MovieListModel?> = MovieObserver(nil) 
    
    func startNetworkTask(urlStr:String, params:[String:Any], resultHandler: @escaping (Result<Data?, Error>) -> Void)  {
        
        let jsonData = Utils.loadJson(filename: "MovieList")
        let decoderObject = JSONDecoder()
        do {
            self.moviesListModel.value = try decoderObject.decode(MovieListModel.self, from: jsonData)
            resultHandler(.success(jsonData))
        } catch {}
    }
    
}
