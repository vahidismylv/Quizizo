//
//  RecordViewController.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 02.10.25.
//

import UIKit

class RecordViewController: BaseViewController {
    private let recordView = RecordContainerView()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let segmentedControl = CustomSegmentedControl()
    
    private var globalUsers: [LeaderboardUser] = []
    private var localUsers: [LeaderboardUser] = []
    
    private var currentUsers: [LeaderboardUser] {
         return segmentedControl.selectedIndex == 0 ? globalUsers : localUsers
     }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(RecordTableViewCell.self, forCellReuseIdentifier: "RecordTableViewCell")
        return table
    }()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActivityIndicator()
                
        loadLeaderboard(isGlobal: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 313).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(recordView)
        recordView.tableView.delegate = self
        recordView.tableView.dataSource = self
        recordView.tableView.rowHeight = 130
                
        recordView.translatesAutoresizingMaskIntoConstraints = false
        recordView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        recordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        recordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        recordView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        recordView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
            
        segmentedControl.onSegmentChanged = { [weak self] index in
            if index == 0 {
                if self?.globalUsers.isEmpty == true {
                    self?.loadLeaderboard(isGlobal: true)
                } else {
                    self?.recordView.tableView.reloadData()
                }
            } else {
                if self?.localUsers.isEmpty == true {
                    self?.loadLeaderboard(isGlobal: false)
                } else {
                    self?.recordView.tableView.reloadData()
                }
            }
        }
            
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func loadLeaderboard(isGlobal: Bool) {
        activityIndicator.startAnimating()
        
        var url = "leaderboard?page=1&limit=50"
        
        if !isGlobal {
            let userCountry = KeychainManager.shared.get(forKey: "userCountry") ?? "AZ"
            url += "&country=\(userCountry)"
        }
        
        if let token = KeychainManager.shared.get(forKey: "authToken") {
            NetworkManager.shared.commonHeaders["Authorization"] = "Bearer \(token)"
        } else {
            print("⚠️ No token in Keychain — cannot fetch leaderboard")
        }
            
        print("🔗 Requesting:", url)
        print("🔑 Headers:", NetworkManager.shared.commonHeaders)
        
        NetworkManager.shared.request(
            url: url,
            method: .GET,
            completion: { [weak self] (result: Result<LeaderboardResponse, NetworkError>) in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    
                    switch result {
                    case .success(let response):
                        print("✅ Leaderboard loaded: \(response.data.leaders.count) users")

                        let usersArray = response.data.leaders
                        
                        if isGlobal {
                            self?.globalUsers = usersArray
                        } else {
                            self?.localUsers = usersArray
                        }

                        let currentUser = response.data.userRank
                        print("👤 My rank: \(currentUser.rank) — position \(currentUser.rankPosition)")

                        self?.recordView.tableView.reloadData()

                    case .failure(let error):
                        print("❌ Leaderboard error: \(error.localizedDescription)")
                        self?.showError(error.localizedDescription)
                    }
                }
            }
        )
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < currentUsers.count else {
               print("⚠️ indexPath.row = \(indexPath.row), но currentUsers.count = \(currentUsers.count)")
               return UITableViewCell()
           }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        let user = currentUsers[indexPath.row]
        
        cell.configure(rank: user.rankPosition, name: user.name, points: user.score, profileImageURL: user.profilePicture, country: user.country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
}
