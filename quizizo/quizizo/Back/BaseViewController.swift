//
//  BaseViewController.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 10.02.26.
//

import UIKit

class BaseViewController: UIViewController {

    let backgroundView = BaseBackgroundView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }

    private func setupBackground() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
