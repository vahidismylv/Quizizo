//
//  WhiteBackgroundView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 09.10.25.
//

import UIKit

class WhiteBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLeftCircles()
        setupRightCircles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLeftCircles() {
        let smallCircle = UIView()
        addSubview(smallCircle)
        smallCircle.translatesAutoresizingMaskIntoConstraints = false
        smallCircle.topAnchor.constraint(equalTo: topAnchor, constant: 192).isActive = true
        smallCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 79).isActive = true
        smallCircle.heightAnchor.constraint(equalToConstant: 14).isActive = true
        smallCircle.widthAnchor.constraint(equalToConstant: 14).isActive = true
        smallCircle.layer.cornerRadius = 7
        smallCircle.backgroundColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)

        
        let mediumCircle = UIView()
        addSubview(mediumCircle)
        mediumCircle.translatesAutoresizingMaskIntoConstraints = false
        mediumCircle.topAnchor.constraint(equalTo: topAnchor, constant: 220).isActive = true
        mediumCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -30).isActive = true
        mediumCircle.widthAnchor.constraint(equalToConstant: 120).isActive = true
        mediumCircle.heightAnchor.constraint(equalToConstant: 120).isActive = true
        mediumCircle.layer.opacity = 0.1
        mediumCircle.layer.cornerRadius = 60
        mediumCircle.backgroundColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0).withAlphaComponent(0.5)
        
        let bigCircle = UIView()
        addSubview(bigCircle)
        bigCircle.translatesAutoresizingMaskIntoConstraints = false
        bigCircle.translatesAutoresizingMaskIntoConstraints = false
        bigCircle.topAnchor.constraint(equalTo: topAnchor, constant: 180).isActive = true
        bigCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -71).isActive = true
        bigCircle.heightAnchor.constraint(equalToConstant: 200).isActive = true
        bigCircle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bigCircle.layer.cornerRadius = 100
        bigCircle.layer.borderWidth = 1
        bigCircle.layer.borderColor = UIColor(ciColor: CIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)).withAlphaComponent(0.1).cgColor
    }
    
    private func setupRightCircles() {
        let rightSmallCircle = UIView()
        addSubview(rightSmallCircle)
        rightSmallCircle.translatesAutoresizingMaskIntoConstraints = false
        rightSmallCircle.topAnchor.constraint(equalTo: topAnchor, constant: 173).isActive = true
        rightSmallCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 274).isActive = true
        rightSmallCircle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        rightSmallCircle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        rightSmallCircle.layer.cornerRadius = 10
        rightSmallCircle.backgroundColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)
        
        let rightMediumCircle = UIView()
        addSubview(rightMediumCircle)
        rightMediumCircle.translatesAutoresizingMaskIntoConstraints = false
        rightMediumCircle.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive = true
        rightMediumCircle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4).isActive = true
        rightMediumCircle.widthAnchor.constraint(equalToConstant: 120).isActive = true
        rightMediumCircle.heightAnchor.constraint(equalToConstant: 120).isActive = true
        rightMediumCircle.layer.opacity = 0.1
        rightMediumCircle.layer.cornerRadius = 60
        rightMediumCircle.backgroundColor = UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0).withAlphaComponent(0.5)
        
        let rightBigCircle = UIView()
        addSubview(rightBigCircle)
        rightBigCircle.translatesAutoresizingMaskIntoConstraints = false
        rightBigCircle.translatesAutoresizingMaskIntoConstraints = false
        rightBigCircle.topAnchor.constraint(equalTo: topAnchor, constant: -1).isActive = true
        rightBigCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 240).isActive = true
        rightBigCircle.heightAnchor.constraint(equalToConstant: 200).isActive = true
        rightBigCircle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        rightBigCircle.layer.cornerRadius = 100
        rightBigCircle.layer.borderWidth = 1
        rightBigCircle.layer.borderColor = UIColor(ciColor: CIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0)).withAlphaComponent(0.1).cgColor
    }
    
}


//import UIKit
//
//class BackgroundView: UIView {
//    private let gradientLayer = CAGradientLayer()
//        
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupGradient()
//    }
//        
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupGradient()
//    }
//    
//    private func setupGradient() {
//    layer.addSublayer(gradientLayer)
//        
//    gradientLayer.colors = [
//        UIColor(red: 226/255, green: 123/255, blue: 245/255, alpha: 1.0).cgColor,
//        UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1.0).cgColor
//    ]
//        
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        
//        addDecorativeCircles()
//        addCircleRight()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        gradientLayer.frame = bounds
//    }
//    
//    private func addDecorativeCircles() {
//        let smallCircle = UIView()
//        addSubview(smallCircle)
//        smallCircle.translatesAutoresizingMaskIntoConstraints = false
//        smallCircle.topAnchor.constraint(equalTo: topAnchor, constant: 296).isActive = true
//        smallCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 79).isActive = true
//        smallCircle.heightAnchor.constraint(equalToConstant: 14).isActive = true
//        smallCircle.widthAnchor.constraint(equalToConstant: 14).isActive = true
//        smallCircle.layer.cornerRadius = 7
//        smallCircle.backgroundColor = UIColor(red: 196/255, green: 208/255, blue: 251/255, alpha: 1.0)
//
//        
//        let mediumCircle = UIView()
//        addSubview(mediumCircle)
//        mediumCircle.translatesAutoresizingMaskIntoConstraints = false
//        mediumCircle.topAnchor.constraint(equalTo: topAnchor, constant: 324).isActive = true
//        mediumCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -30).isActive = true
//        mediumCircle.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        mediumCircle.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        mediumCircle.layer.opacity = 0.1
//        mediumCircle.layer.cornerRadius = 60
//        mediumCircle.backgroundColor = UIColor.white.withAlphaComponent(0.5)
//        
//        let bigCircle = UIView()
//        addSubview(bigCircle)
//        bigCircle.translatesAutoresizingMaskIntoConstraints = false
//        bigCircle.translatesAutoresizingMaskIntoConstraints = false
//        bigCircle.topAnchor.constraint(equalTo: topAnchor, constant: 284).isActive = true
//        bigCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -71).isActive = true
//        bigCircle.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        bigCircle.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        bigCircle.layer.cornerRadius = 100
//        bigCircle.layer.borderWidth = 1
//        bigCircle.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
//    }
//    
//    private func addCircleRight() {
//        let rightSmallCircle = UIView()
//        addSubview(rightSmallCircle)
//        rightSmallCircle.translatesAutoresizingMaskIntoConstraints = false
//        rightSmallCircle.topAnchor.constraint(equalTo: topAnchor, constant: 281).isActive = true
//        rightSmallCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 265).isActive = true
//        rightSmallCircle.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        rightSmallCircle.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        rightSmallCircle.layer.cornerRadius = 10
//        rightSmallCircle.backgroundColor = UIColor(red: 196/255, green: 208/255, blue: 251/255, alpha: 1.0)
//        
//        let rightMediumCircle = UIView()
//        addSubview(rightMediumCircle)
//        rightMediumCircle.translatesAutoresizingMaskIntoConstraints = false
//        rightMediumCircle.topAnchor.constraint(equalTo: topAnchor, constant: 151).isActive = true
//        rightMediumCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 272).isActive = true
//        rightMediumCircle.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        rightMediumCircle.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        rightMediumCircle.layer.opacity = 0.1
//        rightMediumCircle.layer.cornerRadius = 60
//        rightMediumCircle.backgroundColor = UIColor.white.withAlphaComponent(0.5)
//        
//        let rightBigCircle = UIView()
//        addSubview(rightBigCircle)
//        rightBigCircle.translatesAutoresizingMaskIntoConstraints = false
//        rightBigCircle.translatesAutoresizingMaskIntoConstraints = false
//        rightBigCircle.topAnchor.constraint(equalTo: topAnchor, constant: 111).isActive = true
//        rightBigCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 231).isActive = true
//        rightBigCircle.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        rightBigCircle.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        rightBigCircle.layer.cornerRadius = 100
//        rightBigCircle.layer.borderWidth = 1
//        rightBigCircle.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
//    }
//    
//    
//
//}
//
//
