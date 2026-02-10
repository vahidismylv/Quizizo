//
//  RecordTableViewCell.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 06.10.25.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let medalImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.isHidden = true
        return img
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.layer.cornerRadius = 18      
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        label.layer.borderWidth = 1.5
        label.backgroundColor = .clear
        return label
    }()
        
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
        
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
        
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
        
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(red: 133/255, green: 132/255, blue: 148/255, alpha: 1.0)
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        flagImageView.image = nil
        nameLabel.text = nil
        pointsLabel.text = nil
        rankLabel.text = nil
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(medalImageView)
        cardView.addSubview(rankLabel)
        cardView.addSubview(avatarImageView)
        cardView.addSubview(flagImageView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(pointsLabel)
    }
    
    private func setupConstraints() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.widthAnchor.constraint(equalToConstant: 36).isActive = true
        rankLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        rankLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14).isActive = true
        rankLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
               
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 15).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        medalImageView.translatesAutoresizingMaskIntoConstraints = false
        medalImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        medalImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12).isActive = true
        medalImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        medalImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
               
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        flagImageView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 6).isActive = true
        flagImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -1).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
               
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: medalImageView.leadingAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30).isActive = true
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
               
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16).isActive = true
        pointsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
    }
        
    func configure(rank: Int, name: String, points: Int, profileImageURL: String?, country: String) {
        rankLabel.text = "\(rank)"
        nameLabel.text = name
        pointsLabel.text = "\(points) points"
        
        switch rank {
        case 1:
            medalImageView.image = UIImage(named: "goldMedal")
            medalImageView.isHidden = false
        case 2:
            medalImageView.image = UIImage(named: "silverMedal")
            medalImageView.isHidden = false
        case 3:
            medalImageView.image = UIImage(named: "bronzeMedal")
            medalImageView.isHidden = false
        default:
            medalImageView.isHidden = true
        }

        if let urlString = profileImageURL  {
            NetworkManager.shared.downloadImage(from: urlString) { [weak self] result in
                DispatchQueue.main.async {
                    if case .success(let image) = result {
                        self?.avatarImageView.image = image
                    } else {
                        self?.avatarImageView.image = UIImage(systemName: "person.circle.fill")
                    }
                }
            }
        } else {
            avatarImageView.image = UIImage(systemName: "person.circle.fill")
        }

        let flagURLString = "https://flagcdn.com/w40/\(country.lowercased()).png"

        NetworkManager.shared.downloadImage(from: flagURLString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.flagImageView.image = image
                case .failure:
                    self?.flagImageView.image = UIImage(systemName: "flag.fill") // fallback
                }
            }
        }
    }
       
}
