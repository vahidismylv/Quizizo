//
//  HomeContainerView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 02.10.25.
//

import UIKit

class HomeContainerView: UIView {
    
    
    private var worldIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "World")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var starIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Star")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var flagIcon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 6
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private var dividerImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Divider")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var secondDividerImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Divider")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var worldRankLabel: UILabel = {
        let label = UILabel()
        let text = "WORLD RANK"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.kern, value: 0.5, range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
        label.layer.opacity = 0.65
        label.textAlignment = .center
        return label
    }()
    
    private var starRankLabel: UILabel = {
        let label = UILabel()
        let text = "SCORE"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        let attributedString = NSMutableAttributedString(string: text )
        attributedString.addAttribute(.kern, value: 0.5, range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
        label.layer.opacity = 0.65
        label.textAlignment = .center
        return label
    }()
    
    private var localRankLabel: UILabel = {
        let label = UILabel()
        let text = "LOCAL RANK"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.kern, value: 0.5, range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
        label.layer.opacity = 0.65
        label.textAlignment = .center
        return label
    }()
    
    var worldsScoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    var starScoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha:1.0)
        label.textAlignment = .center
        return label
    }()
    
    var localScoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)

        let worldStack = createVerticalStack(icon: worldIcon, title: worldRankLabel, value: worldsScoreLabel)
        let starStack = createVerticalStack(icon: starIcon, title: starRankLabel, value: starScoreLabel)
        let countryStack = createVerticalStack(icon: flagIcon, title: localRankLabel, value: localScoreLabel)
        
        stackView.addArrangedSubview(worldStack)
        stackView.addArrangedSubview(dividerImage)
        stackView.addArrangedSubview(starStack)
        stackView.addArrangedSubview(secondDividerImage)
        stackView.addArrangedSubview(countryStack)
        
        dividerImage.heightAnchor.constraint(equalToConstant: 69).isActive = true
        dividerImage.widthAnchor.constraint(equalToConstant: 1).isActive = true
        secondDividerImage.heightAnchor.constraint(equalToConstant: 69).isActive = true
        secondDividerImage.widthAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor,constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -14).isActive = true
        

        
    }
    
    private func createVerticalStack(icon: UIImageView, title: UILabel, value: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .center  
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
          
        stack.addArrangedSubview(icon)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(value)
        
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return stack
    }
    
    func configure(globalRank: Int, localRank: Int, score: Int, countryCode: String) {
        worldsScoreLabel.text = "#\(globalRank)"
        localScoreLabel.text = "#\(localRank)"
        starScoreLabel.text = "\(score)"

        if let flagURL = URL(string: "https://flagsapi.com/\(countryCode.uppercased())/flat/64.png") {
            loadFlag(from: flagURL)
        }
    }
    
    private func loadFlag(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.flagIcon.image = image
                    self?.flagIcon.layer.cornerRadius = 6
                    self?.flagIcon.clipsToBounds = true
                    self?.flagIcon.contentMode = .scaleAspectFill
                }
            }
        }.resume()
    }
    
    
}

