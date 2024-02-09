//
//  HomeViewController.swift
//  NetworkApp
//
//  Created by Leticia Speda on 25/01/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var screen =  HomeScreen()
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        super.loadView()
        self.screen = HomeScreen()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRequest()
        viewModel.delegate = self
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func success() {
        DispatchQueue.main.async {
            self.screen.configTableViewProtocols(delegate: self, dataSource: self)
            self.screen.tableView.reloadData()
        }
    }
    
    func error(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Houve um problema", message: message, preferredStyle: .alert)
            let addAlert = UIAlertAction(title: "ok", style: .cancel)
            alert.addAction(addAlert)
            self.present(alert, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        cell?.setpHomeCell(data: viewModel.loadCurrentPeople(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
