//
//  PlusContainerView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 04.11.25.
//

import UIKit

class PlusContainerView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plusLabel: UILabel = {
        let txt = UILabel()
        txt.textColor = .white
        txt.font = .systemFont(ofSize: 28, weight: .bold)
        txt.textAlignment = .center
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isHidden = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(plusLabel)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 120),
            containerView.heightAnchor.constraint(equalToConstant: 60),
            
            plusLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            plusLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func show(points: Int, isCorrect: Bool) {
        
        if isCorrect {
            plusLabel.text = "+10"
            containerView.backgroundColor = .systemGreen
        } else {
            plusLabel.text = "-4"
            containerView.backgroundColor = .systemRed
        }
        
        isHidden = false
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        
        UIView.animate(
            withDuration: 0.6,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.containerView.alpha = 1
                self.containerView.transform = .identity
            },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.4,
                    delay: 0.5,
                    options: [],
                    animations: {
                        self.containerView.alpha = 0
                        self.containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    },
                    completion: { _ in
                        self.isHidden = true
                        self.containerView.transform = .identity
                    }
                )
            }
        )
    }
}
