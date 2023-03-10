//
//  MovieListVC.swift
//  MoviesApp
//
//  Created by Nitin Sakhare on 14/02/23.
//

import UIKit
import Kingfisher

class MovieListVC: UIViewController {
    
    @IBOutlet var moviesTableView: UITableView!
    
    private var movieViewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callAPI()
    }
    
    private func setupUI() {
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.estimatedRowHeight = 100
    }
    
    private func callAPI() {
        self.view.activityStartAnimating(activityColor: UIColor.red, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        movieViewModel.fetchMovieList(params: [:]) { onComplete in
        }
        movieViewModel.moviesListModel.bind { [weak self] newsModel in
            DispatchQueue.main.async {
                self?.moviesTableView.reloadData()
            }
        }
        movieViewModel.isToShowLoader.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.view.activityStopAnimating()
            }
        }
    }
    
}

extension MovieListVC:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movieViewModel.moviesListModel.value == nil {
            return 0
        }
        return movieViewModel.moviesListModel.value?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        guard let dataObject = movieViewModel.moviesListModel.value?.results?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.movieTitle.text = dataObject.originalTitle
        if let validURL = dataObject.posterPath {
            let fullURL = URL(string: NetworkProviderConstants.imgBaseURL + validURL)
            cell.movieImgView.kf.setImage(with: fullURL)
        }
        cell.movieImgView.kf.indicatorType = .activity
        
        return cell
    }
    
}

extension MovieListVC:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let dataObject = movieViewModel.moviesListModel.value?.results?[indexPath.row] else {
            return
        }
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as? MovieDetailsVC {
            vc.movieId = String(dataObject.id ?? 0)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
