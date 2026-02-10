//
//  BaseBackgroundView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 10.02.26.
//

import UIKit

final class BaseBackgroundView: UIView {

    private let gradientLayer = CAGradientLayer()

    private let smallCircle = UIView()
    private let mediumCircle = UIView()
    private let bigCircle = UIView()

    private let rightSmallCircle = UIView()
    private let rightMediumCircle = UIView()
    private let rightBigCircle = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        setupGradient()
        setupLeftCircles()
        setupRightCircles()
    }

    private func setupGradient() {
        layer.insertSublayer(gradientLayer, at: 0)

        gradientLayer.colors = [
            UIColor(red: 226/255, green: 123/255, blue: 245/255, alpha: 1).cgColor,
            UIColor(red: 124/255, green: 94/255, blue: 241/255, alpha: 1).cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func setupLeftCircles() {
        configureCircle(
            view: smallCircle,
            size: 14,
            top: 296,
            leading: 79,
            cornerRadius: 7,
            color: UIColor(red: 196/255, green: 208/255, blue: 251/255, alpha: 1)
        )

        configureCircle(
            view: mediumCircle,
            size: 120,
            top: 324,
            leading: -30,
            cornerRadius: 60,
            color: UIColor.white.withAlphaComponent(0.5),
            alpha: 0.1
        )

        configureBorderCircle(
            view: bigCircle,
            size: 200,
            top: 284,
            leading: -71
        )
    }

    private func setupRightCircles() {
        configureCircle(
            view: rightSmallCircle,
            size: 20,
            top: 281,
            leading: 265,
            cornerRadius: 10,
            color: UIColor(red: 196/255, green: 208/255, blue: 251/255, alpha: 1)
        )

        configureCircle(
            view: rightMediumCircle,
            size: 120,
            top: 151,
            leading: 272,
            cornerRadius: 60,
            color: UIColor.white.withAlphaComponent(0.5),
            alpha: 0.1
        )

        configureBorderCircle(
            view: rightBigCircle,
            size: 200,
            top: 111,
            leading: 231
        )
    }

    private func configureCircle(
        view: UIView,
        size: CGFloat,
        top: CGFloat,
        leading: CGFloat,
        cornerRadius: CGFloat,
        color: UIColor,
        alpha: CGFloat = 1
    ) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: top),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            view.widthAnchor.constraint(equalToConstant: size),
            view.heightAnchor.constraint(equalToConstant: size)
        ])

        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = color
        view.alpha = alpha
    }

    private func configureBorderCircle(
        view: UIView,
        size: CGFloat,
        top: CGFloat,
        leading: CGFloat
    ) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: top),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            view.widthAnchor.constraint(equalToConstant: size),
            view.heightAnchor.constraint(equalToConstant: size)
        ])

        view.layer.cornerRadius = size / 2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        view.backgroundColor = .clear
    }
}
