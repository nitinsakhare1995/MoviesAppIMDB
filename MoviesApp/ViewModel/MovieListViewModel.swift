//
//  MovieListViewModel.swift
//  MoviesApp
//
//  Created by Nitin Sakhare on 14/02/23.
//

import Foundation

class MovieListViewModel {
    
    internal let moviesListModel: MovieObserver<MovieListModel?> = MovieObserver(nil)
    private let apiService: APIServiceProtocol
    internal var isToShowLoader: MovieObserver<Bool> = MovieObserver(false) 
    
    init(apiService: APIServiceProtocol = NetworkProvider()) {
        self.apiService = apiService
    }
    
    internal func fetchMovieList(params:[String:Any], complete: @escaping (MovieObserver<MovieListModel?>)->() ) {
        isToShowLoader.value = true
        
        self.apiService.startNetworkTask(urlStr: NetworkProviderConstants.movieListURL, params: [:]) { result in
            self.isToShowLoader.value = false
            switch result {
                
            case .success(let dataObject):
                do {
                    let decoderObject = JSONDecoder()
                    self.moviesListModel.value = try decoderObject.decode(MovieListModel.self, from: dataObject!)
                } catch {
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            complete(self.moviesListModel)
        }
    }
    
}
