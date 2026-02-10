//
//  CustomSegmentedControl.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 01.11.25.
//

import UIKit

class CustomSegmentedControl: UIView {
    
    private var buttons: [UIButton] = []
    private var selectorView: UIView!
    private var selectorLeadingConstraint: NSLayoutConstraint!
    
    var selectedIndex: Int = 0 {
        didSet {
            updateSegmentedControl()
        }
    }
    
    var onSegmentChanged: ((Int) -> Void)?
    
    private let titles = ["Global", "Local"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.white.withAlphaComponent(0.2)
        layer.cornerRadius = 25
        
        selectorView = UIView()
        selectorView.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 213/255, alpha: 1.0)
        selectorView.layer.cornerRadius = 22
        addSubview(selectorView)
        
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            button.setTitleColor(.white, for: .normal)
            button.tag = index
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            addSubview(button)
        }
        
        setupConstraints()
        updateSegmentedControl()
    }
    
    private func setupConstraints() {
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        selectorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        selectorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -8).isActive = true
        
        selectorLeadingConstraint = selectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
        selectorLeadingConstraint.isActive = true
        
        for (index, button) in buttons.enumerated() {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.topAnchor.constraint(equalTo: topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
            
            if index == 0 {
                button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            } else {
                button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            }
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        onSegmentChanged?(selectedIndex)
    }
    
    private func updateSegmentedControl() {
        let offset: CGFloat = selectedIndex == 0 ? 4 : (bounds.width / 2) + 4
        selectorLeadingConstraint.constant = offset
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            self.layoutIfNeeded()
        }
        
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.setTitleColor(.white, for: .normal)
            } else {
                button.setTitleColor(UIColor(red: 185/255, green: 180/255, blue: 228/255, alpha: 1.0), for: .normal)
            }
        }
    }
}
