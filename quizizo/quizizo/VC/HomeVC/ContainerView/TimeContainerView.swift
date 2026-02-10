//
//  TimeContainerView.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 03.10.25.
//

import UIKit

class TimeContainerView: UIView {
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let averageLabel: UILabel = {
        let label = UILabel()
        label.text = "Average time"
        label.font = .systemFont(ofSize: 14, weight: .thin)
        return label
    }()
    
    private let timeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Clock")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 15
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(timeIcon)
        addSubview(timeLabel)
        addSubview(averageLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        timeIcon.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        timeIcon.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -38 ).isActive = true
        
        averageLabel.translatesAutoresizingMaskIntoConstraints = false
        averageLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 3).isActive = true
        averageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
    
    func configUI(time: String, info: String){
        timeLabel.text = time
        averageLabel.text = info
    }
    
    func configApi(time: Double) {
        let formattedTime: String

        if time == 0 {
            formattedTime = "0.0"
        } else if time < 60 {
            formattedTime = String(format: "%.2f", time)
        } else {
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            formattedTime = String(format: "%d:%02d", minutes, seconds)
        }

        timeLabel.text = formattedTime
    }
    

}
