//
//  Untitled.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 06.10.25.
//
import UIKit

class RecordContainerView: UIView {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(RecordTableViewCell.self, forCellReuseIdentifier: "RecordTableViewCell")
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = UIColor(red: 239/255, green: 238/255, blue: 252/255, alpha: 1)
        layer.cornerRadius = 25
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        
        addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: 315).isActive = true
    }
}
