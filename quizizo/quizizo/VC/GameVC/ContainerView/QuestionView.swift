//
//  QuestionView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 13.10.25.
//
import UIKit

class QuestionView: UIView {
    
    private let questionLabel: UILabel = {
        let txt = UILabel()
        txt.font = .systemFont(ofSize: 18, weight: .bold)
        txt.textAlignment = .center
        txt.numberOfLines = 0
        return txt
    }()
    
    private let questionPhoto: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private var photoHeightConstraint: NSLayoutConstraint?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 242/255, green: 232/255, blue: 242/2, alpha: 1.0)
        layer.cornerRadius = 20
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(questionPhoto)
        addSubview(questionLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        questionPhoto.translatesAutoresizingMaskIntoConstraints = false
        questionPhoto.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 15).isActive = true
        questionPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        questionPhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        questionPhoto.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        questionPhoto.heightAnchor.constraint(equalToConstant: 192).isActive = true
        
        photoHeightConstraint = questionPhoto.heightAnchor.constraint(equalToConstant: 0)
        photoHeightConstraint?.isActive = true
        questionPhoto.isHidden = true
    }
    
    func configure(text: String?, image: UIImage?) {
        if let text = text, !text.isEmpty {
            questionLabel.text = text
            questionLabel.isHidden = false
        } else {
            questionLabel.isHidden = true
        }
        
        if let image = image {
            questionPhoto.image = image
            questionPhoto.isHidden = false
            photoHeightConstraint?.constant = 200
        } else {
            questionPhoto.isHidden = true
            photoHeightConstraint?.constant = 0
        }
    }
}
