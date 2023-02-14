//
//  MockAPIServiceMovieDetail.swift
//  MoviesAppTests
//
//  Created by Nitin Sakhare on 14/02/23.
//

import Foundation
@testable import MoviesApp

class MockAPIServiceMovieDetail:  APIServiceProtocol {
    
    let movieDetailModel: MovieObserver<MovieDetailModel?> = MovieObserver(nil)
    
    func startNetworkTask(urlStr:String, params:[String:Any], resultHandler: @escaping (Result<Data?, Error>) -> Void)  {
        
        let jsonData = SwiftUtility.loadJson(filename: "MovieDetail")
        let decoderObject = JSONDecoder()
        do {
            self.movieDetailModel.value = try decoderObject.decode(MovieDetailModel.self, from: jsonData)
            resultHandler(.success(jsonData))
        } catch {}
    }
    
}
