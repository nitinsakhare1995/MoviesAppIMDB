//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Nitin Sakhare on 14/02/23.
//

import Foundation

class MovieDetailViewModel {
    
    internal let moviesDetailModel: MovieObserver<MovieDetailModel?> = MovieObserver(nil)
    private let apiService: APIServiceProtocol
    internal var isToShowLoader: MovieObserver<Bool> = MovieObserver(false)
    
    init(apiService: APIServiceProtocol = NetworkProvider()) {
        self.apiService = apiService
    }
    
    internal func fetchMovieDetails(movieId:String, complete: @escaping (MovieObserver<MovieDetailModel?>)->() ) {
        isToShowLoader.value = true
        
        let finalURL = NetworkProviderConstants.movieDetailURL + movieId + "?api_key=\(NetworkProviderConstants.apiKey)"
        
        apiService.startNetworkTask(urlStr:finalURL, params: [:]) {  result in
            self.isToShowLoader.value = false
            
            switch result {
            case .success(let dataObject):
                do {
                    let decoderObject = JSONDecoder()
                    self.moviesDetailModel.value = try decoderObject.decode(MovieDetailModel.self, from: dataObject!)
                }
                catch {
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            complete(self.moviesDetailModel)
            
        }
    }
    
}
