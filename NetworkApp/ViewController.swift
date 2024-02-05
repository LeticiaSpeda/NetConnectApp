//
//  ViewController.swift
//  NetworkApp
//
//  Created by Leticia Speda on 25/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        viewModel.fetchRequest()
    }
}
