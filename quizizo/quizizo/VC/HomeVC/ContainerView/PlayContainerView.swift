//
//  PlayContainerView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 04.10.25.
//

import UIKit

class PlayContainerView: UIView {
    
    var onTap: (() -> Void)?
    
    private let playIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Play")
        return imageView
    }()
    
    private let playLabel: UILabel = {
        let txt = UILabel()
        txt.text = "Let's Play"
        txt.textColor = .black
        txt.font = .systemFont(ofSize: 16, weight: .bold)
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 15
        setupUI()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(playIcon)
        addSubview(playLabel)
        
        playIcon.translatesAutoresizingMaskIntoConstraints = false
        playLabel.translatesAutoresizingMaskIntoConstraints = false
        
        playIcon.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        playIcon.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 100).isActive = true
        playIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        playLabel.topAnchor.constraint(equalTo: topAnchor, constant: 29).isActive = true
        playLabel.leadingAnchor.constraint(equalTo: playIcon.trailingAnchor, constant: 12).isActive = true
        playLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90).isActive = true
        
        playIcon.heightAnchor.constraint(equalToConstant: 26).isActive = true
        playIcon.widthAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        onTap?()
    }
}
