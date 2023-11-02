//
//  ViewController.swift
//  Film
//
//  Created by cuongnh5 on 27/10/2023.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class ViewController: UIViewController {
    var viewModel: ViewModelProtocol?
    
    func setViewModel(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
    }

    private let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint

        configUI()
    }
    
    func configUI() {
        view.addSubview(movieTableView)
        movieTableView.delegate = self
        movieTableView.dataSource = self
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as? FilmTableViewCell else {
            return UITableViewCell()
        }
        viewModel?.getMovie(onSuccess: {
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        })
        cell.configure(viewModel: self.viewModel!)
        
        return cell
    }
    
    
}
