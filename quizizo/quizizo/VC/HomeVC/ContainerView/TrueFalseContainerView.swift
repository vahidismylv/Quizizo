//
//  TrueFalseContainerView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 04.10.25.
//

import UIKit

class TrueFalseContainerView: UIView {
    
    private let trueIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "True")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let falseIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "False")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cupIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Cup")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let trueLabel: UILabel = {
        let txt = UILabel()
        txt.text = "True"
        txt.textColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        txt.font = .systemFont(ofSize: 12, weight: .semibold)
        txt.layer.opacity = 0.6
        txt.textAlignment = .center
        return txt
    }()
    
    private let totalGamesLabel: UILabel = {
        let txt = UILabel()
        txt.text = "Total Games"
        txt.textColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        txt.font = .systemFont(ofSize: 14, weight: .semibold)
        txt.layer.opacity = 0.6
        txt.textAlignment = .center
        return txt
    }()
    
    private let falseLabel: UILabel = {
        let txt = UILabel()
        txt.text = "False"
        txt.textColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        txt.font = .systemFont(ofSize: 12, weight: .semibold)
        txt.layer.opacity = 0.6
        txt.textAlignment = .center
        return txt
    }()
    
    private let trueCount: UILabel = {
        let txt = UILabel()
        txt.font = .systemFont(ofSize: 15, weight: .bold)
        txt.textColor = .black
        txt.textAlignment = .center
        return txt
    }()
    
    private let totalGamesCount: UILabel = {
        let txt = UILabel()
        txt.font = .systemFont(ofSize: 18, weight: .bold)
        txt.textColor = .black
        txt.textAlignment = .center
        txt.text = "0"
        return txt
    }()
    
    private let falseCount: UILabel = {
        let txt = UILabel()
        txt.font = .systemFont(ofSize: 15, weight: .bold)
        txt.textColor = .black
        txt.textAlignment = .center
        return txt
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let divider: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Divider")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let secondDivider: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Divider")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 15
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        let trueStack = createVerticalStackView(icon: trueIcon, title: trueLabel, point: trueCount)
        let cupStack = createVerticalStackView(icon: cupIcon, title: totalGamesLabel, point: totalGamesCount)
        let falseStack = createVerticalStackView(icon: falseIcon, title: falseLabel, point: falseCount)
        
        
        addSubview(trueStack)
        addSubview(cupStack)
        addSubview(falseStack)
        addSubview(divider)
        addSubview(secondDivider)

        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 69).isActive = true
        divider.widthAnchor.constraint(equalToConstant: 1).isActive = true
        secondDivider.translatesAutoresizingMaskIntoConstraints = false
        secondDivider.heightAnchor.constraint(equalToConstant: 69).isActive = true
        secondDivider.widthAnchor.constraint(equalToConstant: 1).isActive = true
            
        trueIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cupIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        falseIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        trueStack.topAnchor.constraint(equalTo: topAnchor,constant: 33).isActive = true
        trueStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        divider.topAnchor.constraint(equalTo: topAnchor, constant: 31).isActive = true
        divider.leadingAnchor.constraint(equalTo: trueStack.trailingAnchor, constant: 30).isActive = true
        
        cupStack.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
        cupStack.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 30).isActive = true
        
        secondDivider.topAnchor.constraint(equalTo: topAnchor, constant: 31).isActive = true
        secondDivider.leadingAnchor.constraint(equalTo: cupStack.trailingAnchor, constant: 30).isActive = true
        
        falseStack.topAnchor.constraint(equalTo: topAnchor,constant: 33).isActive = true
        falseStack.leadingAnchor.constraint(equalTo: secondDivider.trailingAnchor, constant: 30).isActive = true
        falseStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
    }
    
    
    func createVerticalStackView(icon: UIImageView, title: UILabel, point: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(point)
        
        return stackView
    }
    
    func configApi(correct: Int, wrong: Int) {
        trueCount.text = "\(correct)"
        falseCount.text = "\(wrong)"
    }
    
}
